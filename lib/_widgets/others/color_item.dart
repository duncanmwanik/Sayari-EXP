import 'package:flutter/material.dart';

import '../../_theme/colors.dart';
import '../../_theme/variables.dart';
import '../buttons/planet.dart';
import 'icons.dart';

class ColorItem extends StatefulWidget {
  const ColorItem({
    super.key,
    this.selectedColor,
    required this.color,
    required this.onSelect,
  });

  final String? selectedColor;
  final String color;
  final Function() onSelect;

  @override
  State<ColorItem> createState() => _ColorItemState();
}

class _ColorItemState extends State<ColorItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.selectedColor == widget.color;

    return Planet(
      onPressed: widget.onSelect,
      onHover: (value) => setState(() => isHovered = value),
      isSquare: true,
      width: 30,
      height: 30,
      dryWidth: true,
      padding: noPadding,
      color: backgroundColors[widget.color]!.color,
      child: Center(
        child: AppIcon(
          isHovered && !isSelected ? Icons.lens : Icons.done_rounded,
          size: isHovered ? 10 : 15,
          faded: true,
          color: isSelected || isHovered ? backgroundColors[widget.color]!.textColor : transparent,
        ),
      ),
    );
  }
}
