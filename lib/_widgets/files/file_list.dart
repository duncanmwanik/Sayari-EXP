import 'package:flutter/material.dart';

import '../../_models/item.dart';
import '../../_state/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../others/icons.dart';
import '../others/text.dart';
import '_helpers/helper.dart';
import 'file.dart';
import 'image.dart';

class FileList extends StatelessWidget {
  const FileList({super.key, required this.item, this.isOverview = false});

  final Item item;
  final bool isOverview;

  @override
  Widget build(BuildContext context) {
    Map fileData = item.files(false);
    List filesIds = fileData.keys.toList().where((key) => !isImageFile(fileData[key])).toList();
    List imageIds = fileData.keys.toList().where((key) => isImageFile(fileData[key])).toList();
    Map images = {...fileData};
    images.removeWhere((key, value) => !imageIds.contains(key));

    return Padding(
      padding: padS('t'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          // images
          //
          if (imageIds.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //
                Flexible(
                  child: GridView.extent(
                    shrinkWrap: true,
                    maxCrossAxisExtent: isOverview ? 40 : 80,
                    mainAxisSpacing: tw(),
                    crossAxisSpacing: tw(),
                    children: List.generate(imageIds.length > 4 && isOverview ? 4 : imageIds.length, (index) {
                      String fileId = imageIds[index];
                      String fileName = fileData[fileId];

                      return ImageFile(
                        fileId,
                        fileName,
                        images: images,
                        isOverview: isOverview,
                        size: isOverview ? 30 : (state.views.isChat() ? 550 : 80),
                        radius: isOverview ? borderRadiusTiny : null,
                        selectedIndex: index,
                      );
                    }),
                  ),
                ),
                // overview hidden image count
                if (imageIds.length > 4 && isOverview)
                  Padding(
                    padding: padM(),
                    child: AppText('+ ${imageIds.length - 4}', faded: true),
                  ),
                //
              ],
            ),
          //
          // other files
          //
          if (filesIds.isNotEmpty && imageIds.isNotEmpty) sph(),
          if (filesIds.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // input
                if (!isOverview)
                  Flexible(
                    child: Wrap(
                      spacing: isOverview ? tw() : sw(),
                      runSpacing: isOverview ? tw() : sw(),
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: List.generate(filesIds.length > 5 && isOverview ? 5 : filesIds.length, (index) {
                        String fileId = filesIds[index];
                        String fileName = fileData[fileId];

                        return AppFile(fileId: fileId, fileName: fileName, isOverview: isOverview);
                      }),
                    ),
                  ),
                // overview
                if (isOverview)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcon(Icons.folder, size: small, faded: true),
                      tpw(),
                      Flexible(
                        child: AppText(
                          '${filesIds.length} file${filesIds.length > 1 ? 's' : ''} attached',
                          size: tiny,
                          faded: true,
                        ),
                      ),
                    ],
                  ),
                //
              ],
            ),
          //
        ],
      ),
    );
  }
}
