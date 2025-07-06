import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/extentions/date_time.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/datepicker/sfcalendar.dart';
import '../../../_widgets/others/time_picker.dart';
import '../_helpers/helpers.dart';
import '../_state/date.dart';

class BookingExtras extends StatefulWidget {
  const BookingExtras({super.key});

  @override
  State<BookingExtras> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<BookingExtras> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookingProvider>(builder: (context, booking, child) {
      return Visibility(
        visible: isMediumPC() && !booking.isBooked,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // date picker
            Flexible(
              child: Planet(
                blurred: isImage(),
                padding: padC('l8,r8,b10'),
                color: styler.appColor(0.3),
                radius: borderRadiusMedium,
                child: SfCalendar(
                  onSelect: (selectedDate) {
                    popWhatsOnTop(
                      todo: () => state.temp.set(getDateTime(previous: state.temp.temp, date: selectedDate.datePart())),
                    );
                  },
                  isBookingCalendar: true,
                  initialDates: state.share.item.bookingDates(),
                  width: 300,
                  color: transparent,
                ),
              ),
            ),
            lph(),
            // time picker
            Flexible(
              child: AppTimePicker(
                onTimeChanged: (dateTime) {
                  state.temp.set(getDateTime(previous: state.temp.temp, time: dateTime.timePart()));
                },
              ),
            )
            //
          ],
        ),
      );
    });
  }
}
