import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../../_models/item.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/others/divider_vertical.dart';

class HabitProgressBar extends StatelessWidget {
  const HabitProgressBar({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    int checkedCount = item.checkedHabitDatesCount();

    return Row(
      children: [
        Spacer(),
        AppIcon(FontAwesome.fire_solid, size: small, extraFaded: true),
        tpw(),
        AppText('$checkedCount', size: tinySmall, extraFaded: true),
        AppSeparator(),
        AppIcon(Icons.verified, size: mediumSmall, extraFaded: true),
        tpw(),
        AppText('$checkedCount', size: tinySmall, extraFaded: true),
      ],
    );
  }
}
