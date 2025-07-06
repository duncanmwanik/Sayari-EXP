import 'dart:async';

import '../../../_models/edit.dart';
import '../../../_services/cloud/storage.dart';

Future<void> handleFilesUpload({Map? files, List<EditedKey>? editedKeys}) async {
  if (files != null) {
    files.forEach((id, name) async {
      await storage.uploadFile(id: id, name: name);
    });
  }
  if (editedKeys != null) {
    editedKeys.forEach((editedKey) async {
      if (editedKey.isFile()) {
        if (editedKey.isDelete()) {
          await storage.deleteFile(id: editedKey.key, name: editedKey.value);
        } else {
          await storage.uploadFile(id: editedKey.key, name: editedKey.value);
        }
      }
    });
  }
}
