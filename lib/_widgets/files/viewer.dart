import 'dart:io' as io;
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:photo_view/photo_view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../_helpers/nav/navigation.dart';
import '../../_services/hive/boxes.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_variables/navigation.dart';
import '../buttons/planet.dart';
import '../others/blur.dart';
import '../others/icons.dart';
import '../others/loader.dart';
import '_helpers/cached.dart';
import '_helpers/download.dart';

Future<void> showImageViewer({required Map images, Function()? onDownload, int selectedIndex = 0}) async {
  await showModalBottomSheet(
      context: navigatorState.currentContext!,
      isScrollControlled: true,
      enableDrag: false,
      useSafeArea: true,
      elevation: 0,
      backgroundColor: transparent,
      constraints: BoxConstraints(minWidth: 100.w),
      builder: (context) {
        return Blur(
          blur: 5,
          child: Viewer(images: images, onDownload: onDownload, selectedIndex: selectedIndex),
        );
      });
}

class Viewer extends StatefulWidget {
  const Viewer({super.key, required this.images, this.onDownload, this.selectedIndex = 0});

  final Map images;
  final Function()? onDownload;
  final int selectedIndex;

  @override
  State<Viewer> createState() => _ViewerState();
}

class _ViewerState extends State<Viewer> {
  int selected = 0;
  double scale = 1;
  var quarterTurns = 0;
  PhotoViewController photoViewController = PhotoViewController(initialScale: 1);

  @override
  void initState() {
    setState(() {
      selected = widget.selectedIndex;
    });
    super.initState();
  }

  void rotate90Degrees(String direction) {
    if (direction == 'right') {
      quarterTurns = quarterTurns == 3 ? 0 : quarterTurns + 1;
    } else {
      quarterTurns = quarterTurns == 0 ? 3 : quarterTurns - 1;
    }
    photoViewController.rotation = math.pi / 2 * quarterTurns;
  }

  void zoom(String direction) {
    if (direction == 'in') {
      scale = photoViewController.scale ?? 1;
      photoViewController.scale = scale + 0.2;
    } else if (direction == 'out') {
      scale = photoViewController.scale ?? 1;
      scale = scale > 0.21 ? scale - 0.2 : scale;
      photoViewController.scale = scale;
    } else {
      photoViewController.reset();
    }
  }

  @override
  void dispose() {
    photoViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String fileId = widget.images.keys.toList()[selected];
    String fileName = widget.images[fileId];
    bool isLocal = fileBox.containsKey(fileId);

    return Stack(
      children: [
        //
        // image viewer start
        //
        isLocal
            ? FutureBuilder(
                future: kIsWeb ? Future.delayed(Duration.zero, () => fileBox.get(fileId)) : io.File(fileBox.get(fileId)).readAsBytes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(child: AppLoader(size: 100, color: styler.accent()));
                    } else if (snapshot.hasData) {
                      var bytes = snapshot.data as Uint8List;

                      return PhotoView(
                        controller: photoViewController,
                        backgroundDecoration: BoxDecoration(color: transparent),
                        imageProvider: MemoryImage(bytes),
                      );
                    }
                  }
                  return Center(child: AppLoader(size: 100, color: styler.accent()));
                })
            : FutureBuilder(
                future: getCachedFile(id: fileId, name: fileName),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      File? file = snapshot.data;

                      return file != null
                          ? FutureBuilder(
                              future: file.readAsBytes(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  if (snapshot.hasError) {
                                    return Center(child: AppLoader(size: 100, color: styler.accent()));
                                  } else if (snapshot.hasData) {
                                    var bytes = snapshot.data;

                                    return PhotoView(
                                      controller: photoViewController,
                                      backgroundDecoration: BoxDecoration(color: transparent),
                                      imageProvider: MemoryImage(bytes!),
                                    );
                                  }
                                }
                                return Center(child: AppLoader(size: 100, color: styler.accent()));
                              })
                          : AppIcon(Icons.image_outlined, size: 40, color: styler.appColor(0.5));
                    }
                  }
                  return Planet(
                    radius: 8,
                    padding: EdgeInsets.zero,
                    child: Container(
                      padding: padS(),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(borderRadiusSmall)),
                      child: Center(child: CircularProgressIndicator(color: styler.appColor(2), strokeWidth: 2)),
                    ),
                  );
                }),
        //
        // image viewer end
        //
        // options
        //
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: padM(),
            child: Row(
              children: [
                // actions
                Expanded(
                  child: Wrap(
                    spacing: msw(),
                    runSpacing: sh(),
                    alignment: WrapAlignment.start,
                    children: [
                      Planet(
                        onPressed: () => zoom('in'),
                        noStyling: true,
                        isSquare: true,
                        textColor: white,
                        leading: Icons.add,
                      ),
                      Planet(
                        onPressed: () => zoom('out'),
                        noStyling: true,
                        isSquare: true,
                        textColor: white,
                        leading: Icons.remove,
                      ),
                      Planet(
                        onPressed: () => zoom(noValue),
                        noStyling: true,
                        isSquare: true,
                        textColor: white,
                        leading: Icons.fullscreen,
                      ),
                      Planet(
                        onPressed: () => rotate90Degrees('left'),
                        noStyling: true,
                        isSquare: true,
                        textColor: white,
                        leading: Icons.rotate_90_degrees_ccw_outlined,
                      ),
                      Planet(
                        onPressed: () => rotate90Degrees('right'),
                        noStyling: true,
                        isSquare: true,
                        textColor: white,
                        leading: Icons.rotate_90_degrees_cw_outlined,
                      ),
                      Planet(
                        onPressed: widget.onDownload ?? () => downloadFile(id: fileId, name: fileName),
                        noStyling: true,
                        isSquare: true,
                        textColor: white,
                        leading: Icons.download_outlined,
                      ),
                      if (!kIsWeb)
                        Planet(
                          onPressed: () {},
                          noStyling: true,
                          isSquare: true,
                          textColor: white,
                          leading: Icons.open_in_new_rounded,
                        ),
                      //
                    ],
                  ),
                ),
                // close viewer
                Planet(
                  onPressed: () => popWhatsOnTop(),
                  isSquare: true,
                  noStyling: true,
                  textColor: white,
                  iconSize: 25,
                  leading: closeIcon,
                ),
                //
              ],
            ),
          ),
        ),
        //
        // options end
        //
        // next/previous image
        //
        if (widget.images.length > 1)
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: pad(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // previous
                  Planet(
                    onPressed: () {
                      if (selected > 0) {
                        setState(() => selected -= 1);
                      }
                      photoViewController.reset();
                    },
                    iconSize: 30,
                    isSquare: true,
                    color: styler.appColor(0.5),
                    textColor: white,
                    leading: Icons.keyboard_arrow_left_rounded,
                  ),
                  // next
                  Planet(
                    onPressed: () {
                      if (selected < widget.images.length - 1) {
                        setState(() => selected += 1);
                      }
                      photoViewController.reset();
                    },
                    isSquare: true,
                    iconSize: 30,
                    color: styler.appColor(0.5),
                    textColor: white,
                    leading: Icons.keyboard_arrow_right_rounded,
                  ),
                  //
                ],
              ),
            ),
          )
        // next/previous image  end
      ],
    );
  }
}
