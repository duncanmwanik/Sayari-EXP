import 'dart:async';

import '../../../_services/cloud/storage.dart';

Future<void> handleFilesDeletion(Map files) async {
  files.forEach((id, name) async {
    storage.deleteFile(id: id, name: name);
  });
}
