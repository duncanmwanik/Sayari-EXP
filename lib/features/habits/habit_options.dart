import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_helpers/common/global.dart';
import '../../_state/input.dart';
import '../../_variables/constants.dart';
import '../../_widgets/dialogs/confirmation_dialog.dart';
import '../../_widgets/dialogs/dialog_select_date.dart';
import '../../_widgets/menu/menu_item.dart';

class HabitOptions extends StatelessWidget {
  const HabitOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      List<String> customDates = input.item.customHabitDates();

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          MenuItem(
            label: '${customDates.isNotEmpty ? 'Edit' : 'Select'} Target Dates',
            leading: Icons.calendar_month_rounded,
            onTap: () async {
              // TOCHECK
              await showDateDialog(
                showTitle: true,
                isMultiple: true,
                initialDates: customDates,
                onDone: (selectedDates) {
                  if (selectedDates.isNotEmpty && !DeepCollectionEquality().equals(selectedDates, customDates)) {
                    input.update(itemHabitCustomDates, joinList(selectedDates));
                  }
                },
              );
            },
          ),
          //
          if (customDates.isNotEmpty)
            MenuItem(
              label: 'Remove Target Dates',
              leading: Icons.close,
              onTap: () => showConfirmationDialog(
                title: 'Remove custom dates?',
                content: 'You will now be able to check habits each day. Already checked dates will be kept.',
                yeslabel: 'Remove',
                onAccept: () => input.remove(itemHabitCustomDates),
              ),
            ),
          //
        ],
      );
    });
  }
}
