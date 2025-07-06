import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../share/w_settings/shared.dart';
import 'bookings_list.dart';
import 'options.dart';

class Booking extends StatelessWidget {
  const Booking({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Padding(
        padding: padM('t'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //
            tph(),
            ShareSettings(
              widget: BookingOptions(),
            ),
            mph(),
            BookingsList(),
            //
          ],
        ),
      );
    });
  }
}
