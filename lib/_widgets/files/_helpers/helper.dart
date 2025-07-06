import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:open_filex/open_filex.dart';

import '../../../_helpers/extentions/strings.dart';
import '../../../_services/hive/boxes.dart';
import '../../others/toast.dart';

Map getFiles(Map source, {bool deep = false, bool showHidden = false}) {
  Map data = {...source};
  Map files = {};

  data.forEach((parentKey, parentValue) {
    if (parentValue is Map && deep) {
      parentValue.forEach((subKey, subValue) async {
        if (subKey.toString().isFile(showHidden)) {
          files[subKey] = subValue;
        }
      });
    } else {
      if (parentKey.toString().isFile(showHidden)) {
        files[parentKey] = parentValue;
      }
    }
  });

  return files;
}

bool isImageFile(String fileName) => ['png', 'jpg', 'jpeg', 'webp', 'jfif'].contains(getfileExtension(fileName));
// bool isImageEmbed(String fileId) => fileId.startsWith('fle');

String getfileExtension(String fileName) {
  try {
    return fileName.split('.').last;
  } catch (e) {
    return '';
  }
}

String getfileNameOnly(String fileName) {
  try {
    return fileName.split('.').first;
  } catch (e) {
    return 'FILE';
  }
}

String getCloudFileName(String id, String name) => '$id.${getfileExtension(name)}';

void openFile(String fileId) {
  bool isFileDownloaded = fileBox.containsKey(fileId);
  if (isFileDownloaded && !kIsWeb) {
    try {
      OpenFilex.open(fileBox.get(fileId));
    } catch (e) {
      toastError('Failed to open file');
    }
  }
}

Future<String> getDownloadUrl(String fileName) async {
  return await FirebaseStorage.instance.ref().child('Flutter.png').getDownloadURL();
}
