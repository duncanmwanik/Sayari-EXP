import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../_theme/spacing.dart';
import '../buttons/planet.dart';
import 'icons.dart';
import 'text.dart';

class EmptyBox extends StatelessWidget {
  const EmptyBox({
    super.key,
    this.label = 'Nothing here...',
    this.icon = Icons.bolt,
    // this.icon = FontAwesome.ghost_solid,
    this.centered = true,
    this.showImage = true,
    this.onPressed,
    this.size,
  });

  final String label;
  final IconData icon;
  final bool centered;
  final bool showImage;
  final double? size;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    var column = Planet(
      onPressed: onPressed,
      noStyling: onPressed == null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // icon
          if (showImage)
            AppIcon(
              icon,
              size: size ?? 10.h,
              faded: true,
              padding: padL('b'),
            ).animate().shake(),
          // label
          AppText(label, faded: true),
          //
        ],
      ).animate().fadeIn(),
    );
    return centered ? Center(child: column) : column;
  }
}
