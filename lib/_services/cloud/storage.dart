import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../_helpers/common/global.dart';
import '../../_helpers/debug/debug.dart';
import '../../_variables/constants.dart';
import '../../_widgets/files/_helpers/helper.dart';
import '../../_widgets/others/toast.dart';
import '../../features/spaces/_helpers/common.dart';
import '../hive/boxes.dart';
import '_helpers/storage_errors.dart';

CloudStorage storage = CloudStorage();

class CloudStorage {
  final Map<String, Reference> refs = {
    def: FirebaseStorage.instanceFor(app: Firebase.app(), bucket: 'gs://getsayari.appspot.com').ref(),
    spaces: FirebaseStorage.instanceFor(app: Firebase.app(), bucket: 'gs://sayarispaces').ref(),
    users: FirebaseStorage.instanceFor(app: Firebase.app(), bucket: 'gs://sayariusers').ref(),
  };

  Reference ref(String db) => refs[db]!;

  // uploading

  Future<bool> uploadFile({String db = spaces, String? parent, required String id, required String name}) async {
    if (!isDemo()) return true;

    bool success = false;

    if (fileBox.containsKey(id)) {
      try {
        String path = '${parent ?? liveSpace()}/${getCloudFileName(id, name)}';
        if (kIsWeb) {
          ref(db).child(path).putData(fileBox.get(id)).snapshotEvents.listen(
                (taskSnapshot) => fileProgress(db, id, 'uploading', taskSnapshot),
              );
        } else {
          ref(db).child(path).putFile(File(fileBox.get(id))).snapshotEvents.listen(
                (taskSnapshot) => fileProgress(db, id, 'uploading', taskSnapshot),
              );
        }
        await fileBox.delete(id); // releases memory used to store file bytes
        success = true;
      } on FirebaseException catch (e) {
        toastError('Failed to upload $name. Trying again soon...');
        show(handleFirebaseStorageError(e, process: 'upload file'));
      } catch (e) {
        logError('uploadFile-[$parent/$id/$name]', e);
      }
    }
    {
      // toastError( 'Failed to upload $name.');
    }

    return success;
  }

  // delete

  Future<bool> deleteFile({String db = spaces, String? parent, required String id, required String name}) async {
    if (!isDemo()) return true;

    bool success = false;
    String path = '${parent ?? liveSpace()}/${getCloudFileName(id, name)}';

    try {
      await ref(db).child(path).delete().then((value) => show('cloudDeleteFile: $path'));
      success = true;
    } on FirebaseException catch (e) {
      logError('cloudDeleteFile: $path', e);
    } catch (e) {
      logError('cloudDeleteFile: $path', e);
    }

    return success;
  }

  // download

  Future<bool> downloadFile({
    String db = spaces,
    String? parent,
    required String id,
    required String name,
    required String downloadPath,
  }) async {
    bool success = false;
    String path = '${parent ?? liveSpace()}/${getCloudFileName(id, name)}';

    try {
      if (kIsWeb) {
        // String fileUrl = await fileRef.getDownloadURL();
        // downloadFileOnWeb(fileId, fileUrl);
      }
      //
      else {
        await Permission.storage.request();
        String filePath = '/storage/emulated/0/Sayari/$downloadPath';
        final file = File(filePath);
        final downloadTask = ref(db).child(path).writeToFile(file);
        downloadTask.snapshotEvents.listen((taskSnapshot) => fileProgress(db, name, 'downloading', taskSnapshot));
      }
      success = true;
    } on FirebaseException catch (e) {
      toastError(handleFirebaseStorageError(e, process: 'download file'));
    } catch (e) {
      logError('donloadFile', e);
    }
    return success;
  }

  // get url

  Future<String> getFileUrl({String db = spaces, String? space, required String id, required String name}) async {
    String path = '${space ?? liveSpace()}/${getCloudFileName(id, name)}';

    try {
      String fileUrl = await ref(db).child(path).getDownloadURL();
      return fileUrl;
    } catch (e) {
      logError('getFileUrl: $path', e);
      return '';
    }
  }

  // get bytes

  Future<Uint8List?> getFileBytes({String db = spaces, String? parent, required String id, required String name}) async {
    String path = '${parent ?? liveSpace()}/${getCloudFileName(id, name)}';

    try {
      Uint8List? bytes = await ref(db).child(path).getData();
      return bytes;
    } catch (e) {
      logError('getFileBytes: $path', e);
      return null;
    }
  }

  // progress logger

  void fileProgress(String db, String path, String process, dynamic taskSnapshot) {
    {
      switch (taskSnapshot.state) {
        case TaskState.running:
          // TODOs: Handle this case.
          show('.... $process $db file: $path');
          break;
        case TaskState.paused:
          // TODOs: Handle this case.
          show('....paused $process $db file: $path');
          break;
        case TaskState.success:
          // TODOs: Handle this case.
          show('....done $process $db file: $path');
          break;
        case TaskState.canceled:
          // TODOs: Handle this case.
          show('....canceled $process $db file: $path');
          break;
        case TaskState.error:
          // TODOs: Handle this case.
          show('....error $process $db file: $path');
          break;
      }
    }
  }
}
