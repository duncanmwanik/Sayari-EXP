import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/common/global.dart';
import '../../../_helpers/extentions/date_time.dart';
import '../../../_models/date.dart';
import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/dialogs/dialog_select_time.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class BookingTimes extends StatelessWidget {
  const BookingTimes({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      List<String> availableTimes = input.item.bookingTimes();

      return Wrap(
        runSpacing: sw(),
        spacing: sw(),
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // add button
          Planet(
            onPressed: () async {
              String time = '';
              await showTimeDialog(
                onTimeChanged: (dateTime) {
                  time = dateTime.timePart();
                },
              );
              if (time.isNotEmpty) {
                availableTimes.add(time);
                input.update(itemBookingTimes, joinList(availableTimes));
              }
            },
            slp: true,
            radius: borderRadiusCrazy,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.add_rounded, size: 18, faded: true),
                tpw(),
                AppText('Add Time', size: small),
              ],
            ),
          ),
          // times
          for (String time in availableTimes)
            Planet(
              padding: EdgeInsets.only(left: 10),
              color: styler.accent(6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(DateItem.fromTime(time).timePart12()),
                  tpw(),
                  Planet(
                    onPressed: () {
                      availableTimes.remove(time);
                      input.update(itemBookingTimes, joinList(availableTimes));
                    },
                    noStyling: true,
                    isSquare: true,
                    child: AppIcon(Icons.close_rounded, size: 16),
                  )
                ],
              ),
            ),
          //
          if (availableTimes.isEmpty) AppText('Set your prefered hours.', size: small, faded: true),
          //
        ],
      );
    });
  }
}
