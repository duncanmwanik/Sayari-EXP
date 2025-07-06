import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/common/global.dart';
import '../../../_helpers/extentions/date_time.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_models/date.dart';
import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/dialogs/dialog_select_date.dart';
import '../../../_widgets/dialogs/dialog_select_time.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../bookings/_helpers/helpers.dart';

class DateTimePicker extends StatelessWidget {
  const DateTimePicker({super.key, required this.type});
  final String type;

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      DateItem date = DateItem(input.item.data[type] ?? now().format());
      String previous = type == itemStart ? input.item.start() : input.item.end();

      return Wrap(
        spacing: sw(),
        runSpacing: tw(),
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          //
          SizedBox(
            width: 60,
            child: AppText(type == itemStart ? 'Starts at:' : 'Ends at:', faded: true),
          ),
          // info
          Planet(
            enabled: input.item.isNew,
            onPressed: () async => await showDateDialog(
              initialDate: date.date,
              onSelect: (selectedDate) {
                input.update(type, getDateTime(previous: previous, date: selectedDate.datePart()));
                popWhatsOnTop();
              },
            ),
            srp: true,
            showBorder: true,
            noStyling: true,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: AppText(date.dateInfo())),
                spw(),
                AppIcon(editIcon, size: small, faded: true),
              ],
            ),
          ),
          // edit
          Planet(
            onPressed: () async => await showTimeDialog(
              initial: date.dateTime,
              onTimeChanged: (selectedTime) {
                input.update(type, getDateTime(previous: previous, time: selectedTime.timePart()));
              },
            ),
            srp: true,
            showBorder: true,
            noStyling: true,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(child: AppText(date.timePart12())),
                spw(),
                AppIcon(editIcon, size: small, faded: true),
              ],
            ),
          ),
          //
        ],
      );
    });
  }
}
