// ignore_for_file: implementation_imports

import 'dart:io' as io;

import 'package:file/file.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../_helpers/debug/debug.dart';
import '../../../_services/cloud/storage.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_variables/constants.dart';
import '../../../features/spaces/_helpers/common.dart';
import '../../others/toast.dart';
import 'cached.dart';

Future<void> downloadFile(
    {String id = '', String name = '', String? db, String? cloudFilePath, String? downloadPath, bool fromCloud = false}) async {
  try {
    toastInfo('Downloading $name...');
    //
    // local
    //
    if (fileBox.containsKey(id) && (kIsWeb || await io.File(fileBox.get(id)).exists()) && !fromCloud) {
      show('downloading from local fileBox...');
      if (kIsWeb) {
        var bytes = fileBox.get(id);
        await FileSaver.instance.saveFile(name: name, bytes: bytes);
      } else {
        await Permission.storage.request();
        io.File file = io.File(
          downloadPath != null ? '/storage/emulated/0/Sayari/$name' : '/storage/emulated/0/Sayari/${liveSpaceTitle()}/$name',
        );
        await file.create(recursive: true);
        var bytes = await io.File(fileBox.get(id)).readAsBytes();
        await file.writeAsBytes(bytes);
      }
      toastSuccess('Downloaded $name.');
    }
    //
    // cached
    //
    else if (cachedFileUrlsBox.containsKey(id) && !fromCloud) {
      show('downloading from cache...');
      File? cachedFile = await getCachedFile(id: id, name: name);
      if (cachedFile != null) {
        var bytes = await cachedFile.readAsBytes();

        if (kIsWeb) {
          await FileSaver.instance.saveFile(name: name, bytes: bytes);
        } else {
          await Permission.storage.request();
          io.File file = io.File(
            downloadPath != null ? '/storage/emulated/0/Sayari/$name' : '/storage/emulated/0/Sayari/${liveSpaceTitle()}/$name',
          );
          await file.create(recursive: true);
          await file.writeAsBytes(bytes);
        }

        toastSuccess('Downloaded $name.');
      } else {
        show('Redownloading from cloud...');
        downloadFile(id: id, name: name, db: db, cloudFilePath: cloudFilePath, downloadPath: downloadPath, fromCloud: true);
      }
    }
    //
    // cloud
    //
    else {
      show('downloading from cloud...');
      await storage.getFileBytes(db: db ?? spaces, id: id, name: name).then((bytes) async {
        if (bytes != null) {
          if (kIsWeb) {
            await FileSaver.instance.saveFile(name: name, bytes: bytes);
          } else {
            await Permission.storage.request();
            io.File file = io.File(
              downloadPath != null
                  ? '/storage/emulated/0/Sayari/$name'
                  : '/storage/emulated/0/Sayari/${liveSpaceTitle(defaultValue: 'Others')}/$name',
            );
            await file.create(recursive: true);
            await file.writeAsBytes(bytes);
          }
          toastSuccess('Downloaded $name.');
        }
      });
    }
    //
  } catch (e) {
    toastSuccess('Could not download $name.');
    logError('download-file', e);
  }
}
