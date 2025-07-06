import 'package:flutter/material.dart';

import '../../_models/item.dart';
import '../../_state/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../features/notes/actions/actions.dart';
import '../buttons/planet.dart';
import '../others/icons.dart';
import '../others/text.dart';
import '_helpers/helper.dart';
import 'image.dart';

class ItemCover extends StatelessWidget {
  const ItemCover({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    String fileId = item.coverId();
    String fileName = item.coverName();

    return SizedBox(
      height: item.isInput ? 300 : 130,
      width: double.maxFinite,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          //
          isImageFile(fileName)
              ? ImageFile(fileId, fileName)
              : Planet(
                  onPressed: item.isInput ? () {} : null,
                  radius: borderRadiusMediumSmall,
                  padding: EdgeInsets.zero,
                  noStyling: true,
                  child: Container(
                    decoration: BoxDecoration(
                      color: styler.appColor(styler.isDark ? 0.5 : 0.8),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(borderRadiusSmall - 3),
                        topRight: Radius.circular(borderRadiusSmall - 3),
                        bottomLeft: item.isInput ? Radius.circular(borderRadiusSmall) : Radius.zero,
                        bottomRight: item.isInput ? Radius.circular(borderRadiusSmall) : Radius.zero,
                      ),
                    ),
                    child: Center(
                        child: Padding(
                      padding: padL(),
                      child: AppText(
                        fileName,
                        textAlign: TextAlign.center,
                        weight: FontWeight.w600,
                        faded: true,
                      ),
                    )),
                  ),
                ),
          // remove note pinned file
          if (item.isInput)
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Planet(
                  onPressed: () => state.input.remove('w'),
                  noStyling: true,
                  isSquare: true,
                  child: AppIcon(Icons.cancel, tiny: true, extraFaded: true),
                ),
              ),
            ),
          //
          if (!item.isInput) ItemActions(doc: item),
          //
        ],
      ),
    );
  }
}
