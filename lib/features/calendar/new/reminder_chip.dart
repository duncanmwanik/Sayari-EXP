import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/common/global.dart';
import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/forms/numeric.dart';
import '../../../_widgets/others/icons.dart';
import '../../notes/w/picker_type.dart';
import '../../reminders/_helpers/reminders.dart';

class ReminderChip extends StatelessWidget {
  const ReminderChip({super.key, required this.reminder});

  final String reminder;

  @override
  Widget build(BuildContext context) {
    String reminderNo = reminder.split('.')[0];
    String reminderPeriod = reminder.split('.')[1];

    return Consumer<InputProvider>(builder: (context, input, child) {
      return Planet(
        padding: padT(),
        noStyling: true,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // reminder period
            Flexible(
              child: NumericFormInput(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    String newReminder = '${value.trim()}.$reminderPeriod';
                    List remindersList = splitList((input.item.reminder()));
                    remindersList.remove(reminder);
                    remindersList.add(newReminder);
                    input.update(itemReminder, joinList(remindersList));
                  }
                },
                hintText: 'No.',
                initialValue: reminderNo,
                maxLength: 2,
                width: 38,
                color: transparent,
                padding: noPadding,
                borderRadius: borderRadiusSmall,
              ),
            ),
            // reminder period
            Flexible(
              child: AppTypePicker(
                onSelect: (chosenKey, chosenValue) {
                  String newReminder = '$reminderNo.$chosenValue';
                  List remindersList = splitList((input.item.reminder()));
                  remindersList.remove(reminder);
                  remindersList.add(newReminder);
                  input.update(itemReminder, joinList(remindersList));
                },
                initial: reminderPeriodsMap[reminderPeriod],
                typeEntries: {'minutes': 'm', 'hours': 'h', 'days': 'd', 'weeks': 'w'},
                svp: true,
                borderRadius: borderRadiusSmall,
                color: transparent,
                padding: padC('l8,r8,t4,b4'),
              ),
            ),
            // remove reminder
            Planet(
              onPressed: () {
                List remindersList = splitList((input.item.reminder()));
                remindersList.remove(reminder);
                if (remindersList.isEmpty) {
                  input.remove(itemReminder);
                } else {
                  input.update(itemReminder, joinList(remindersList));
                }
              },
              margin: padS('l'),
              noStyling: true,
              isSquare: true,
              child: AppIcon(Icons.close, size: medium),
            ),
            //
          ],
        ),
      );
    });
  }
}
