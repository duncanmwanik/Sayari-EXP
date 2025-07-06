import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/menu/model.dart';
import '../../../_widgets/others/icons.dart';

class QuickHabitActions extends StatelessWidget {
  const QuickHabitActions({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Planet(
      menu: Menu(
        items: [
          MenuItem(
            label: 'Ignore Today',
            leading: Icons.close,
            onTap: () {},
          ),
          MenuItem(
            label: 'Delete Habit',
            leading: Icons.delete,
            onTap: () {},
          )
        ],
      ),
      isSquare: true,
      noStyling: true,
      margin: padM('l'),
      child: AppIcon(moreIcon, extraFaded: true),
    );
  }
}
