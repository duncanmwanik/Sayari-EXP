import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_models/item.dart';
import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/others/text.dart';
import 'booking_item.dart';

class BookingsList extends StatelessWidget {
  const BookingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      List bookings = input.item.bookings();

      return bookings.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(bookings.length, (index) {
                return BookingItem(
                  booking: Item(
                    id: bookings[index],
                    data: input.item.data[bookings[index]],
                  ),
                );
              }),
            )
          : Center(
              child: Padding(
                padding: padL('t'),
                child: AppText('No bookings yet...', faded: true),
              ),
            );
    });
  }
}
