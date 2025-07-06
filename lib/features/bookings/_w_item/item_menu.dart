import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../_widgets/menu/menu_item.dart';

List<Widget> bookingItemMenu(Item booking) {
  bool isDone = booking.isChecked();

  return [
    MenuItem(
      label: isDone ? 'Mark As Pending' : 'Mark As Done',
      leading: isDone ? Icons.timelapse_rounded : Icons.done_rounded,
      onTap: () {
        state.input.update(itemChecked, isDone ? 0 : 1, parentKey: booking.id);
      },
    ),
    // MenuItem(
    //   label: 'Change Date & Time',
    //   leading: editIcon,
    //   onTap: () {
    //     // showChangeBookingDateDialog(
    //     //   name: name,
    //     //   date: date,
    //     //   time: time,
    //     //   onDone: (newDate, newTime, sendEmail) {
    //     //     booking['bbd'] = newDate;
    //     //     booking['bbt'] = newTime;
    //     //     booking['bbc'] = '0';
    //     //     input.update(bookingKey, jsonEncode(booking));
    //     //   },
    //     // );
    //   },
    // ),
    MenuItem(
      label: 'Remove Booking',
      leading: deleteIcon,
      onTap: () => showConfirmationDialog(
        title: 'Remove booking session with <b>${booking.title()}</b>?',
        yeslabel: 'Remove',
        onAccept: () => state.input.remove(booking.id),
      ),
    ),
  ];
}
