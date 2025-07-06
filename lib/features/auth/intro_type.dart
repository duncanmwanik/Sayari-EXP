import 'package:flutter/material.dart';

import '../../_theme/helpers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/files/image.dart';
import '../../_widgets/others/text.dart';
import 'var/model.dart';

class IntroType extends StatefulWidget {
  const IntroType({super.key, required this.feature});

  final IntroFeature feature;

  @override
  State<IntroType> createState() => _IntroFeatureState();
}

class _IntroFeatureState extends State<IntroType> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Planet(
      noStyling: true,
      padding: noPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Planet(
            showBorder: isLight(),
            color: white,
            radius: 15,
            margin: padL('r'),
            padding: padC('l18,r18,t12,b12'),
            child: AppText(widget.feature.message, size: 15, weight: ft6, color: black),
          ),
          //
          mph(),
          Flexible(
            child: ImageFile(
              widget.feature.type,
              '${widget.feature.type}.png',
              db: def,
              space: intro,
              showOptions: false,
              ignore: true,
              offline: true,
              fit: BoxFit.fitWidth,
              alignment: Alignment.topLeft,
              radius: 10,
              height: 300,
            ),
          ),
          //
        ],
      ),
    );
  }
}
