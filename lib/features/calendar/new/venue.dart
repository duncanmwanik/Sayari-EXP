import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/forms/input.dart';
import '../../../_widgets/others/icons.dart';

class Venue extends StatelessWidget {
  const Venue({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(
        builder: (context, input, child) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // icon
                Padding(
                  padding: padC('t12,r8'),
                  child: AppIcon(Icons.location_on, faded: true, size: extra),
                ),
                // input
                Expanded(
                  child: DataInput(
                    inputKey: itemVenue,
                    hintText: 'Venue',
                    keyboardType: TextInputType.name,
                    color: transparent,
                  ),
                ),
                //
              ],
            ));
  }
}
