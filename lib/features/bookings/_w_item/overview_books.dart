import 'package:flutter/material.dart';

import '../../../_models/date.dart';
import '../../../_models/item.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';

class BookingOverviewItems extends StatelessWidget {
  const BookingOverviewItems({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    List bookings = item.bookings();

    return SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(bookings.length, (index) {
          Item booking = Item(
            id: bookings[index],
            data: item.data[bookings[index]],
          );

          return Planet(
            margin: padMS('b'),
            padding: noPadding,
            noStyling: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppIcon(
                      Icons.check_circle,
                      size: small,
                      extraFaded: true,
                      // color: item.isChecked() ? Colors.green : Colors.blue,
                      padding: padC('t3'),
                    ),
                    tspw(),
                    Flexible(
                      child: AppText(
                        size: small,
                        DateItem(booking.start()).info(),
                        faded: true,
                        maxlines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: padC('l22'),
                  child: AppText(
                    size: small,
                    booking.title(),
                    faded: true,
                    maxlines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
