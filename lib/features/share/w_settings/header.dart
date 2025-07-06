import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/share.dart';

class ShareItemHeader extends StatelessWidget {
  const ShareItemHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool isExpanded = input.item.isExpanded();

      return Row(
        spacing: sw(),
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          Planet(
            onPressed: () => input.update(itemExpand, isExpanded ? 0 : 1),
            tooltip: '${isExpanded ? 'Hide' : 'Show'} Settings',
            tooltipDirection: AxisDirection.up,
            slp: true,
            srp: true,
            svp: true,
            showBorder: true,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(FontAwesome.earth_africa_solid, size: medium, faded: true),
                spw(),
                Flexible(child: AppText('Shared')),
                tspw(),
                AppIcon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 18, faded: true),
              ],
            ),
          ),
          //
          if (isExpanded && !input.item.isLink() && !input.item.isBooking())
            Planet(
              onPressed: () => unshareItem(),
              tooltip: 'Unshare',
              noStyling: true,
              padding: padS(),
              child: AppIcon(deleteIcon, size: medium, extraFaded: true),
            ),
          //
        ],
      );
    });
  }
}
