import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/extentions/date_time.dart';
import '../../../_helpers/extentions/strings.dart';
import '../../../_models/date.dart';
import '../../../_state/_providers.dart';
import '../../../_state/temp.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/dialogs/dialog_select_time.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../notes/w/picker_type.dart';
import '../_helpers/helpers.dart';

class BookingTime extends StatelessWidget {
  const BookingTime({super.key});

  @override
  Widget build(BuildContext context) {
    List specifiedTimes = state.share.item.bookingTimes();

    return Consumer<TempProvider>(
      builder: (context, temp, child) {
        String label = temp.temp.hasTimePart() && temp.temp.hasDatePart()
            ? DateItem(temp.temp).timePart12()
            : temp.temp.hasTimePart() && !temp.temp.hasDatePart()
                ? DateItem.fromTime(temp.temp).timePart12()
                : 'Choose Time';

        return Planet(
          blurred: isImage(),
          margin: padM('t'),
          padding: padC('l14,r8,t8,b8'),
          color: styler.appColor(isDarkOnly() ? 0.3 : 0.7),
          radius: borderRadiusMediumSmall,
          maxWidth: 500,
          child: Row(
            children: [
              //
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppIcon(Icons.access_time_rounded, size: 16, faded: true),
                  spw(),
                  Flexible(child: AppText('Time', faded: true)),
                ],
              ),
              //
              Spacer(),
              // time chooser
              if (specifiedTimes.isEmpty)
                Planet(
                  enabled: !isSmallPC(),
                  onPressed: () async => await showTimeDialog(
                    onTimeChanged: (dateTime) {
                      temp.set(getDateTime(previous: temp.temp, time: dateTime.timePart()));
                    },
                  ),
                  srp: true,
                  radius: borderRadiusMedium - 8,
                  color: temp.temp.hasTimePart() ? styler.accent(8) : styler.appColor(0.6),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText(label),
                      spw(),
                      AppIcon(Icons.keyboard_arrow_right, size: normal),
                    ],
                  ),
                ),
              // time picker
              if (specifiedTimes.isNotEmpty)
                AppTypePicker(
                  initial: label,
                  typeEntries: {for (var time in specifiedTimes) DateItem.fromTime(time).timePart12(): time},
                  onSelect: (chosenType, chosenValue) {
                    temp.set(getDateTime(previous: temp.temp, time: chosenValue));
                  },
                  borderRadius: borderRadiusMedium - 8,
                  color: styler.appColor(0.6),
                )
              //
            ],
          ),
        );
      },
    );
  }
}
