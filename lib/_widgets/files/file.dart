// ignore_for_file: dead_code

import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../_services/hive/boxes.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../buttons/planet.dart';
import '../others/text.dart';
import '_helpers/helper.dart';
import 'options.dart';
import 'var/variables.dart';

// TODOs: Verify path exists
// TODOs: Get web path

class AppFile extends StatelessWidget {
  const AppFile({super.key, required this.fileId, required this.fileName, this.bgColor, this.isOverview = false});

  final String fileId;
  final String fileName;
  final String? bgColor;
  final bool isOverview;

  @override
  Widget build(BuildContext context) {
    bool isDownloading = false;

    return ValueListenableBuilder(
        valueListenable: fileBox.listenable(),
        builder: (context, box, widget) {
          return Planet(
            onPressed: () async => openFile(fileId),
            padding: noPadding,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // extension
                Container(
                  decoration: BoxDecoration(
                    color: fileTypeColors[getfileExtension(fileName)] ?? Colors.blue,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(borderRadiusTiny),
                      bottomLeft: Radius.circular(borderRadiusTiny),
                    ),
                  ),
                  padding: padS(),
                  child: AppText(getfileExtension(fileName).toUpperCase(), color: white, size: tiny),
                ),
                // name
                if (!isOverview) spw(),
                if (!isOverview) Flexible(child: AppText(fileName)),
                if (!isOverview) spw(),
                //
                if (!isOverview && isDownloading) SizedBox(height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 3)),
                //
                if (!isOverview) FileOptions(fileId, fileName),
                //
              ],
            ),
          );
        });
  }
}
