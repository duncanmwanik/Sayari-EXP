import 'package:flutter/material.dart';

import '../../_helpers/nav/navigation.dart';
import '../../_theme/colors.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../buttons/planet.dart';
import 'color_item.dart';
import 'icons.dart';

class AppColorPicker extends StatelessWidget {
  const AppColorPicker({
    super.key,
    this.selectedColor,
    this.onSelect,
    this.onRemove,
    this.showRemove = true,
    this.showNone = false,
    this.pop = true,
  });

  final String? selectedColor;
  final Function(String newColor)? onSelect;
  final Function()? onRemove;
  final bool showRemove;
  final bool showNone;
  final bool pop;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: tw(),
      runSpacing: tw(),
      children: [
        //
        if (showRemove)
          Planet(
            onPressed: () => popWhatsOnTop(pop: pop, todo: () => onRemove != null ? onRemove!() : onSelect!('')),
            isSquare: true,
            width: 30,
            height: 30,
            dryWidth: true,
            padding: noPadding,
            color: styler.appColor(1),
            child: Center(child: AppIcon(Icons.close, size: normal, faded: true)),
          ),
        //
        if (showNone)
          Planet(
            onPressed: () => popWhatsOnTop(pop: pop, todo: () => onSelect!('')),
            isSquare: true,
            width: 30,
            height: 30,
            dryWidth: true,
            padding: noPadding,
            color: styler.appColor(1),
            child: Center(child: AppIcon(Icons.not_interested, size: normal, extraFaded: true)),
          ),
        //
        for (String color in backgroundColors.keys)
          ColorItem(
            color: color,
            selectedColor: selectedColor,
            onSelect: () => popWhatsOnTop(pop: pop, todo: () => onSelect!(color)),
          ),
        //
      ],
    );
  }
}
