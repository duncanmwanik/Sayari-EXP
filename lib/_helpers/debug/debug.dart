import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

var logger = Logger(
  filter: ProductionFilter(),
  printer: PrettyPrinter(
    printEmojis: false,
    printTime: false,
  ),
  // output: AppFileOutput(),
);

void logError(String where, var e) {
  logger.e('APP-ERROR: ($where)\n$e');
}

void show(var object) {
  logger.w(object);
}

class AppFileOutput extends LogOutput {
  AppFileOutput();

  late File file;

  @override
  void output(OutputEvent event) async {
    final Directory? downloadsDir = await getDownloadsDirectory();
    File file = File('${downloadsDir?.path}/app.log');

    for (var line in event.lines) {
      await file.writeAsString('${line.toString()}\n', mode: FileMode.writeOnlyAppend);
      debugPrint(line); //print to console as well
    }
  }
}
