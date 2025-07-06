import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_theme/colors.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/text.dart';

class SessionType extends StatelessWidget {
  const SessionType({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Planet(
      color: backgroundColors[item.color()]!.color,
      padding: padC('l8,r8,t1,b1'),
      child: AppText(
        item.typee(),
        size: small,
        weight: FontWeight.w600,
        color: backgroundColors[item.color()]!.textColor,
      ),
    );
  }
}
