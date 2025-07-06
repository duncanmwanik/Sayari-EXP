import 'package:flutter/material.dart';

import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../buttons/planet.dart';
import 'icons.dart';
import 'other.dart';

class AppCheckBox extends StatefulWidget {
  const AppCheckBox({
    super.key,
    required this.isChecked,
    this.onTap,
    this.radius = 5,
    this.size = normal,
    this.color,
    this.borderColor,
    this.margin,
    this.showCheck = false,
  });

  final bool isChecked;
  final Function()? onTap;
  final Color? color;
  final Color? borderColor;
  final double radius;
  final double size;
  final EdgeInsets? margin;
  final bool showCheck;

  @override
  State<AppCheckBox> createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? noPadding,
      child: Material(
        color: transparent,
        child: InkWell(
          onTap: widget.onTap,
          onHover: (value) => setState(() => isHovered = value),
          borderRadius: BorderRadius.circular(widget.radius * 1.2),
          child: Planet(
            width: widget.size,
            height: widget.size,
            margin: padS(),
            padding: noPadding,
            color: widget.isChecked ? widget.color ?? styler.accent() : transparent,
            radius: widget.radius,
            showBorder: !widget.isChecked,
            borderWidth: widget.size / 10,
            borderColor: widget.borderColor ?? styler.appColor(5),
            mouseCursor: SystemMouseCursors.click,
            child: Center(
              child: widget.isChecked || widget.showCheck || isHovered
                  ? AppIcon(
                      Icons.done_rounded,
                      size: widget.size * 0.8,
                      extraFaded: true,
                      color: widget.isChecked ? white : null,
                    )
                  : const NoWidget(),
            ),
          ),
        ),
      ),
    );
  }
}
