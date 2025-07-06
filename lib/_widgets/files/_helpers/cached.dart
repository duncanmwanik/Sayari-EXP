import 'dart:typed_data';

import 'package:file/file.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import '../../../_helpers/common/helpers.dart';
import '../../../_helpers/debug/debug.dart';
import '../../../_services/cloud/storage.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../../../features/spaces/_helpers/common.dart';

Future<File?> getCachedFile({
  String id = '',
  String name = '',
  String? db,
  String? space,
  String? url,
  bool offline = false,
}) async {
  File? file;

  try {
    String fileUrl = url ?? cachedFileUrlsBox.get(id, defaultValue: '');
    String spaceId = space ?? (isShare() ? state.share.spaceId : liveSpace());
    // bool isOffline = offlineFilesBox.containsKey(id);
    // if (isOffline) {
    //   await file!.writeAsBytes(offlineFilesBox.get(id, defaultValue: []));
    // }
    //
    if (fileUrl.isEmpty) {
      fileUrl = await storage.getFileUrl(db: db ?? spaces, space: spaceId, id: id, name: name);
      if (fileUrl.isNotEmpty) cachedFileUrlsBox.put(id, fileUrl);
      // show('::Gotten cached file url: $id - $name');
    }

    file = await DefaultCacheManager().getSingleFile(fileUrl);

    if (offline && !offlineFilesBox.containsKey(id)) {
      Uint8List bytes = await file.readAsBytes();
      offlineFilesBox.put(id, bytes);
    }
  } catch (e) {
    logError('getCachedFile: $id  $id', e);
  }

  return file;
}
