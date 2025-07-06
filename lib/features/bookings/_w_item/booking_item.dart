import 'package:flutter/material.dart';

import '../../../_models/date.dart';
import '../../../_models/item.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/menu/model.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import 'item_menu.dart';

class BookingItem extends StatelessWidget {
  const BookingItem({super.key, required this.booking});

  final Item booking;

  @override
  Widget build(BuildContext context) {
    bool isDone = booking.isChecked();
    bool isMissed = DateItem(booking.start()).isPast();

    return Planet(
        srp: true,
        color: styler.appColor(0.3),
        margin: padMS('t'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            Row(
              children: [
                //
                Flexible(
                  child: AppText(DateItem(booking.start()).dateInfo(), weight: FontWeight.bold),
                ),
                mspw(),
                AppIcon(
                  isDone ? Icons.check_circle : Icons.timelapse,
                  tiny: true,
                  color: isDone ? Colors.green : (isMissed ? Colors.red : Colors.blue),
                ),
                spw(),
                Planet(
                  menu: Menu(items: bookingItemMenu(booking)),
                  noStyling: true,
                  isRound: true,
                  child: AppIcon(moreIcon, size: 18, faded: true),
                ),
                //
              ],
            ),
            //
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 50,
                  child: AppText('Name:', faded: true),
                ),
                Flexible(child: AppText(booking.title(), faded: true)),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 50,
                  child: AppText('Email:', faded: true),
                ),
                Flexible(child: AppText(booking.end(), faded: true)),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 50,
                  child: AppText('About:', faded: true),
                ),
                Flexible(child: AppText(booking.content(), faded: true)),
              ],
            ),
            ph(2),
            //
          ],
        ));
  }
}
