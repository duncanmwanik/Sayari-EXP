import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import 'dates.dart';
import 'times.dart';

class BookingOptions extends StatelessWidget {
  const BookingOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool isExpanded = input.item.isExpanded();

      return Padding(
        padding: padM('t'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isExpanded) sph(),
            if (isExpanded) BookingDates(),
            if (isExpanded) sph(),
            if (isExpanded) BookingTimes(),
          ],
        ),
      );
    });
  }
}
