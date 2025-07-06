import 'package:flutter/material.dart';

import '../../_theme/helpers.dart';
import '../../_theme/variables.dart';
import '../buttons/planet.dart';
import '../menu/model.dart';
import 'icons.dart';

class ColorButton extends StatelessWidget {
  const ColorButton({
    super.key,
    this.color,
    required this.menu,
    this.padding,
  });

  final String? color;
  final Menu menu;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    bool hasColor = hasColour(color);

    return Planet(
      tooltip: 'Color',
      menu: menu,
      noStyling: true,
      isSquare: true,
      padding: padding,
      child: AppIcon(
        Icons.circle,
        size: normal,
        color: hasColor ? styler.getItemBgColor(color, false) : (styler.isDark ? Colors.white24 : Colors.black54),
      ),
    );
  }
}
