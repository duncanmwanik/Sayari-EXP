import 'package:flutter/material.dart';

import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../buttons/planet.dart';
import 'icons.dart';

class AppSeparator extends StatelessWidget {
  const AppSeparator({
    super.key,
    this.padding,
    this.isVertical = false,
  });

  final EdgeInsets? padding;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    return isVertical
        ? Planet(
            width: 1.5,
            height: 18,
            padding: padding ?? noPadding,
            color: styler.appColor(1),
          )
        : AppIcon(
            Icons.circle,
            size: 2,
            extraFaded: true,
            padding: padding ?? padS('lr'),
          );
  }
}
