import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/extentions/date_time.dart';
import '../../../_helpers/extentions/strings.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_models/date.dart';
import '../../../_state/_providers.dart';
import '../../../_state/temp.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/dialogs/dialog_select_date.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../../notes/w/picker_type.dart';
import '../_helpers/helpers.dart';

class BookingDate extends StatelessWidget {
  const BookingDate({super.key});

  @override
  Widget build(BuildContext context) {
    List specifiedDates = state.share.item.bookingDates();

    return Consumer<TempProvider>(
      builder: (context, temp, child) {
        String label = temp.temp.hasDatePart() ? DateItem(temp.temp).dateInfo() : 'Choose Date';

        return Planet(
          blurred: isImage(),
          margin: padL('t'),
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
                  AppIcon(Icons.calendar_month, size: normal, faded: true),
                  spw(),
                  Flexible(child: AppText('Date', faded: true)),
                ],
              ),
              //
              Spacer(),
              // date chooser
              if (specifiedDates.isEmpty)
                Planet(
                  enabled: !isSmallPC(),
                  onPressed: () async => await showDateDialog(
                    initialDate: temp.temp.hasDatePart() ? temp.temp.datePart() : null,
                    onSelect: (selectedDate) {
                      temp.set(getDateTime(previous: temp.temp, date: selectedDate.datePart()));
                      popWhatsOnTop();
                    },
                  ),
                  srp: true,
                  radius: borderRadiusMedium - 8,
                  color: temp.temp.hasDatePart() ? styler.accent(8) : styler.appColor(0.6),
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
              // date picker
              if (specifiedDates.isNotEmpty)
                AppTypePicker(
                  initial: label,
                  typeEntries: {for (var date in specifiedDates) DateItem(date).dateInfo(): date},
                  onSelect: (chosenType, chosenValue) {
                    temp.set(getDateTime(previous: temp.temp, date: chosenValue));
                  },
                  borderRadius: borderRadiusMedium - 8,
                  color: temp.temp.hasDatePart() ? styler.accent(8) : styler.appColor(0.6),
                )
              //
            ],
          ),
        );
      },
    );
  }
}
