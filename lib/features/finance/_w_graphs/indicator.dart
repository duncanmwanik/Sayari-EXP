import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    this.size = tiny,
  });
  final Color color;
  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Planet(
      onPressed: () {},
      color: color.withOpacity(0.1),
      margin: padS('t'),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AppIcon(Icons.circle, size: size, color: color),
          spw(),
          AppText(text),
        ],
      ),
    );
  }
}
