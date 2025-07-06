import 'package:flutter/material.dart';

import '../../_models/date.dart';
import '../../_models/item.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import 'edit_menu.dart';

class Reminder extends StatelessWidget {
  const Reminder({
    super.key,
    required this.item,
  });
  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padS('t'),
      child: Planet(
        menu: reminderMenu(item),
        svp: true,
        slp: true,
        srp: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // icon
            AppIcon(Icons.notifications_active, size: 12, faded: true),
            tpw(),
            // text
            Flexible(
              child: AppText(
                size: tiny,
                DateItem(item.reminder()).info(),
                faded: true,
                isCrossed: item.hasReminderPassed(),
              ),
            ),
            //
          ],
        ),
      ),
    );
  }
}
