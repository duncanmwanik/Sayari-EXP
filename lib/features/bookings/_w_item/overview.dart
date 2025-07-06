import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import 'overview_books.dart';

class BookingOverview extends StatelessWidget {
  const BookingOverview({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    List bookings = item.bookings();
    int bookingsCount = bookings.length;

    return Padding(
      padding: padM('t'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          tph(),
          // no of bookings
          Row(
            children: [
              if (bookings.isNotEmpty) AppIcon(Icons.calendar_month, size: small, faded: true, padding: padS('lr')),
              Flexible(
                child: AppText(
                  size: small,
                  bookings.isNotEmpty ? '$bookingsCount booking${bookingsCount > 1 ? 's' : ''}' : 'No bookings yet.',
                  faded: true,
                ),
              ),
            ],
          ),
          msph(),
          //
          BookingOverviewItems(item: item),
          //
        ],
      ),
    );
  }
}
