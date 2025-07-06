import 'dart:ui';

import 'package:flutter/material.dart';

class Blur extends StatelessWidget {
  const Blur({
    super.key,
    this.enabled = true,
    this.blur,
    this.width,
    this.height,
    this.radius,
    this.borderRadius,
    required this.child,
  });

  final bool enabled;
  final double? blur;
  final double? radius;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: enabled ? (borderRadius ?? (radius != null ? BorderRadius.circular(radius!) : BorderRadius.zero)) : BorderRadius.zero,
      child: BackdropFilter(
        filter: enabled ? ImageFilter.blur(sigmaX: blur ?? 80, sigmaY: blur ?? 80) : ImageFilter.blur(),
        blendMode: BlendMode.srcOver,
        child: SizedBox(
          width: width,
          height: height,
          child: child,
        ),
      ),
    );
  }
}
