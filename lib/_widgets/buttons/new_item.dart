import 'package:flutter/material.dart';

import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../others/icons.dart';
import 'planet.dart';

class NewItem extends StatelessWidget {
  const NewItem({
    super.key,
    required this.label,
    required this.onPressed,
    this.margin,
  });

  final String label;
  final Function() onPressed;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Planet(
      margin: margin ?? padM('r'),
      onPressed: onPressed,
      child: AppIcon(Icons.add, color: styler.accent()),
    );
  }
}
