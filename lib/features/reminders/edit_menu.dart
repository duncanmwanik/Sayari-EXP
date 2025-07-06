import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_helpers/extentions/date_time.dart';
import '../../_helpers/nav/navigation.dart';
import '../../_models/date.dart';
import '../../_models/item.dart';
import '../../_services/cloud/sync/quick_edit.dart';
import '../../_state/_providers.dart';
import '../../_state/temp.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_variables/features.dart';
import '../../_widgets/buttons/action.dart';
import '../../_widgets/dialogs/dialog_select_date.dart';
import '../../_widgets/dialogs/dialog_select_time.dart';
import '../../_widgets/menu/menu_item.dart';
import '../../_widgets/menu/model.dart';
import '../bookings/_helpers/helpers.dart';
import '_helpers/helper.dart';

Menu reminderMenu(Item item) {
  state.temp.set(item.hasReminder() ? item.reminder() : newReminderTime(), notify: false);

  return Menu(
    items: [
      MenuItem(label: '${item.hasReminder() ? 'Edit' : 'Set'} reminder', sh: true, popTrailing: true),
      menuDivider(),
      Consumer<TempProvider>(builder: (context, temp, child) {
        DateItem date = DateItem(temp.temp);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // date
            MenuItem(
              label: date.dateInfo(),
              leading: editIcon,
              pop: false,
              onTap: () async => await showDateDialog(
                initialDate: date.date,
                onSelect: (selectedDate) {
                  state.temp.set(getDateTime(previous: temp.temp, date: selectedDate.datePart()));
                  popWhatsOnTop();
                },
              ),
            ),
            tph(),
            // time
            MenuItem(
              label: date.timePart12(),
              leading: Icons.access_time,
              pop: false,
              onTap: () async => await showTimeDialog(
                initial: date.dateTime,
                onTimeChanged: (selectedTime) {
                  state.temp.set(getDateTime(previous: temp.temp, time: selectedTime.timePart()));
                },
              ),
            ),
          ],
        );
      }),
      sph(),
      Row(
        children: [
          // remove
          ActionButton(
            isCancel: true,
            label: 'Remove',
            onPressed: () {
              popWhatsOnTop(
                todo: () {
                  if (item.isInput) {
                    state.input.remove(itemReminder);
                  } else {
                    quickEdit(
                      action: 'd',
                      parent: features.docs,
                      id: item.id,
                      sid: item.sid,
                      key: itemReminder,
                    );
                  }
                },
              ); // close menu
            },
          ),
          Spacer(),
          // cancel
          ActionButton(isCancel: true),
          // save
          ActionButton(
            label: item.hasReminder() ? 'Save' : 'Add',
            onPressed: () {
              popWhatsOnTop(
                todo: () {
                  if (item.isInput) {
                    state.input.update(itemReminder, state.temp.temp);
                  } else {
                    quickEdit(
                      parent: features.docs,
                      id: item.id,
                      key: itemReminder,
                      value: state.temp.temp,
                      sid: item.sid,
                    );
                  }
                },
              ); // close menu
            },
          ),
        ],
      )
    ],
  );
}
