import 'dart:math';

import 'package:flutter/material.dart';

import '../../_theme/variables.dart';

class AppIcon extends StatelessWidget {
  const AppIcon(
    this.iconData, {
    super.key,
    this.color,
    this.size,
    this.containSize,
    this.tiny = false,
    this.mildFaded = false,
    this.faded = false,
    this.extraFaded = false,
    this.rotation = 0,
    this.padding,
  });

  final IconData? iconData;
  final Color? color;
  final double? size;
  final double? containSize;
  final bool tiny;
  final bool mildFaded;
  final bool faded;
  final bool extraFaded;
  final int rotation;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? noPadding,
      child: SizedBox(
        width: containSize,
        height: containSize,
        child: Transform.rotate(
          angle: rotation * pi / 180,
          child: Icon(
            iconData,
            size: size ?? (tiny ? 18 : 20),
            color: color ?? styler.textColor(mildFaded: mildFaded, faded: faded, extraFaded: extraFaded),
            opticalSize: 5,
          ),
        ),
      ),
    );
  }
}
