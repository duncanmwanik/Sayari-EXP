import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../_models/item.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/files/image.dart';
import '../../../_widgets/others/icons.dart';

class SharedLinkCover extends StatelessWidget {
  const SharedLinkCover({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    String coverId = item.coverId();
    String coverName = item.coverName();
    bool hasCover = coverId.isNotEmpty;

    return (hasCover
            ? ImageFile(
                coverId,
                coverName,
                images: {coverId: coverName},
                size: 40,
                radius: borderRadiusCrazy,
                color: transparent,
                showOptions: false,
                ignore: true,
              )
            : SizedBox(
                width: 40,
                height: 40,
                child: AppIcon(Icons.link, faded: true),
              ))
        .animate()
        .fadeIn();
  }
}
