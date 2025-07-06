import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/common/global.dart';
import '../../../_models/date.dart';
import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/dialogs/dialog_select_date.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class BookingDates extends StatelessWidget {
  const BookingDates({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      List<String> availableDates = input.item.bookingDates();

      return Wrap(
        spacing: sw(),
        runSpacing: sw(),
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          // add button TOCHECK
          Planet(
            onPressed: () async {
              await showDateDialog(
                showTitle: true,
                isMultiple: true,
                initialDates: availableDates,
                onDone: (selectedDates) {
                  if (selectedDates.isNotEmpty) {
                    input.update(itemBookingDates, joinList(selectedDates));
                  }
                },
              );
            },
            slp: true,
            radius: borderRadiusCrazy,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(Icons.add_rounded, tiny: true, faded: true),
                tpw(),
                AppText('Add Date', size: small),
              ],
            ),
          ),
          // dates
          for (String date in availableDates)
            Planet(
              padding: padC('l10'),
              color: styler.accent(6),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(DateItem(date).dateInfo()),
                  tph(),
                  Planet(
                    onPressed: () {
                      availableDates.remove(date);
                      input.update(itemBookingDates, joinList(availableDates));
                    },
                    noStyling: true,
                    isSquare: true,
                    child: AppIcon(Icons.close_rounded, size: 16),
                  )
                ],
              ),
            ),
          //
          if (availableDates.isEmpty) AppText('Set your prefered dates.', size: small, faded: true),
          //
        ],
      );
    });
  }
}
