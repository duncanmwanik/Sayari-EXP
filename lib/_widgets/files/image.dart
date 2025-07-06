// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:io' as io;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart' as cfile;

import '../../_helpers/extentions/dynamic.dart';
import '../../_services/hive/boxes.dart';
import '../../_state/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../buttons/planet.dart';
import '../others/icons.dart';
import '../others/loader.dart';
import '../others/other.dart';
import '_helpers/cached.dart';
import 'options.dart';
import 'viewer.dart';

class ImageFile extends StatelessWidget {
  const ImageFile(
    this.fileId,
    this.fileName, {
    super.key,
    this.db,
    this.space,
    this.url,
    this.images = const {},
    this.isOverview = false,
    this.radius,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.alignment = Alignment.center,
    this.color,
    this.hoverColor,
    this.size,
    this.width,
    this.height,
    this.showOptions = true,
    this.showLoading = true,
    this.ignore = false,
    this.offline = false,
    this.onPressed,
    this.selectedIndex = 0,
    this.provider,
  });

  final String fileId;
  final String fileName;
  final String? db;
  final String? space;
  final String? url;
  final bool isOverview;
  final bool showOptions;
  final bool showLoading;
  final bool ignore;
  final bool offline;
  final double? size;
  final double? width;
  final double? height;
  final double? radius;
  final BorderRadius? borderRadius;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final Color? color;
  final Color? hoverColor;
  final Function()? onPressed;
  final Map images;
  final int selectedIndex;
  final Future<cfile.File?>? provider;

  @override
  Widget build(BuildContext context) {
    bool isValid = (fileId.isNotEmpty && fileName.isNotEmpty) || url.ok();
    bool isLocal = fileBox.containsKey(fileId);
    bool isOffline = offlineFilesBox.containsKey(fileId);
    BorderRadius? borderRadius_ = borderRadius ?? BorderRadius.circular(radius ?? borderRadiusSmall);

    // show('$fileId --- $fileName --- valid: $isValid --- local: $isLocal --- offline: $isOffline');

    return SizedBox(
      height: height ?? size,
      width: width ?? size,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          //
          // if image is valid ----------
          //
          if (isValid)
            Planet(
              enabled: !ignore,
              onPressed: onPressed ?? (() => showImageViewer(images: images, selectedIndex: selectedIndex)),
              color: color,
              hoverColor: hoverColor,
              radius: 8,
              borderRadius: borderRadius,
              padding: noPadding,
              noStyling: true,
              child:
                  //  for images available offline
                  isOffline
                      ? Container(
                          decoration: BoxDecoration(
                              borderRadius: borderRadius_,
                              image: DecorationImage(image: MemoryImage(offlineFilesBox.get(fileId)), fit: fit, alignment: alignment)),
                        )
                      :
                      // for images still in file picker box
                      isLocal
                          ? FutureBuilder(
                              future: kIsWeb
                                  ? Future.delayed(Duration.zero, () => fileBox.get(fileId))
                                  : io.File(fileBox.get(fileId)).readAsBytes(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  if (snapshot.hasError) {
                                    return AppIcon(Icons.question_mark_rounded, faded: true);
                                  } else if (snapshot.hasData) {
                                    var bytes = snapshot.data as Uint8List;

                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: borderRadius_,
                                        image: DecorationImage(image: MemoryImage(bytes), fit: fit, alignment: alignment),
                                      ),
                                    );
                                  }
                                }
                                return Center(child: showLoading ? AppLoader() : NoWidget());
                              })
                          :
                          // for cloud images, which are cached afterwards
                          FutureBuilder(
                              future:
                                  provider ?? getCachedFile(db: db, space: space, id: fileId, name: fileName, url: url, offline: offline),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  if (snapshot.hasError) {
                                    return AppIcon(Icons.question_mark, color: styler.appColor(0.5));
                                  } else if (snapshot.hasData) {
                                    cfile.File? file = snapshot.data;

                                    return file != null
                                        ? FutureBuilder(
                                            future: file.readAsBytes(),
                                            builder: (context, snapshot) {
                                              if (snapshot.connectionState == ConnectionState.done) {
                                                if (snapshot.hasError) {
                                                  return AppIcon(Icons.question_mark, faded: true);
                                                } else if (snapshot.hasData) {
                                                  var bytes = snapshot.data;

                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: borderRadius_,
                                                      image: DecorationImage(
                                                        image: MemoryImage(bytes!),
                                                        fit: fit,
                                                        alignment: alignment,
                                                      ),
                                                    ),
                                                  );
                                                }
                                              }
                                              return Center(child: showLoading ? AppLoader() : NoWidget());
                                            })
                                        : AppIcon(Icons.image, extraFaded: true);
                                  }
                                }

                                // for loading process
                                return Container(
                                  padding: padS(),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius ?? borderRadiusSmall)),
                                  child: Center(child: CircularProgressIndicator(color: styler.appColor(2), strokeWidth: 2)),
                                );
                              }),
            ),

          //
          // if image is invalid ----------
          //
          if (!isValid)
            Planet(
              radius: radius ?? borderRadiusSmall,
              color: color,
              hoverColor: hoverColor,
              padding: padS(),
              borderRadius: borderRadius,
              child: Center(child: AppIcon(Icons.question_mark, extraFaded: true)),
            ),
          //
          // image options ----------
          //
          if (!isOverview && !state.views.isChat() && showOptions)
            Align(
              alignment: Alignment.bottomRight,
              child: FileOptions(fileId, fileName),
            ),
          //
        ],
      ),
    );
  }
}
