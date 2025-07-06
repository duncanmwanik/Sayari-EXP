import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

import '../../../_helpers/common/global.dart';
import '../../../_helpers/debug/debug.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../model.dart';

Future<void> getFilesToUpload({
  bool single = false,
  bool imagesOnly = false,
  bool hidden = false,
  bool cover = false,
  bool addToInput = true,
  String? parentKey,
  Function(FileStash stash)? onDone,
}) async {
  try {
    FilePickerResult? results = await FilePicker.platform.pickFiles(
      allowMultiple: !single,
      type: imagesOnly ? FileType.custom : FileType.any,
      allowedExtensions: imagesOnly ? ['jpg', 'jpeg', 'png', 'webp'] : null,
    );

    if (results != null) {
      List<PlatformFile> files = results.files;
      FileStash stash = FileStash();

      for (PlatformFile file in files) {
        // show(file.size);
        // double sizeInMb = file.size / (1024 * 1024);
// if (sizeInMb > 5){
//     // This file is Longer the
// }
        String fileId = '${cover ? itemFileCover : hidden ? itemFileHidden : itemFile}${getUniqueId()}';
        FileItem fileItem = FileItem(id: fileId, name: file.name);
        stash.addFile(fileId, fileItem);
        await fileBox.put(fileId, kIsWeb ? file.bytes : file.path);

        if (addToInput) {
          if (parentKey != null) {
            state.input.update(fileId, parentKey: parentKey, file.name);
          } else {
            state.input.update(fileId, file.name);
          }
        }
      }

      if (stash.isValid()) onDone!(stash);
    }
  } catch (e) {
    logError('getFilesToUpload', e);
  }
}
