import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/common/global.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import 'reminder_chip.dart';

class Reminders extends StatelessWidget {
  const Reminders({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      List remindersList = splitList((input.item.reminder()));

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // icon
          Padding(
            padding: padC('t6,r16'),
            child: AppText('Reminders:', size: mediumSmall, faded: true),
          ),
          //
          Expanded(
            child: Wrap(
              spacing: sw(),
              runSpacing: sw(),
              children: [
                // reminders
                for (String reminder in remindersList) ReminderChip(reminder: reminder),
                // add reminder
                Planet(
                  onPressed: () async {
                    hideKeyboard();
                    remindersList.add('30.m');
                    input.update('r', joinList(remindersList));
                  },
                  noStyling: true,
                  slp: true,
                  isSquare: remindersList.isNotEmpty,
                  margin: padT('t'),
                  tooltip: 'Add Reminder',
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcon(Icons.notification_add, faded: true, size: normal),
                      if (remindersList.isEmpty) spw(),
                      if (remindersList.isEmpty) AppText('Add Reminder', faded: true),
                    ],
                  ),
                ),
                //
              ],
            ),
          ),
          //
        ],
      );
    });
  }
}
