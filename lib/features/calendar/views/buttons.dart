import 'package:flutter/material.dart';

import '../../../_helpers/common/global.dart';
import '../../../_helpers/extentions/date_time.dart';
import '../../../_models/date.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../_helpers/helpers.dart';
import '../_helpers/swipe.dart';

class ChangeButtons extends StatelessWidget {
  const ChangeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Planet(
      padding: noPadding,
      showBorder: true,
      noStyling: true,
      margin: padM('lr'),
      radius: borderRadiusLarge,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // previous date
          Planet(
            onPressed: () => swipeToNew(direction: 'left'),
            tooltip: 'Previous',
            padding: padC('l8,r8,t3,b3'),
            noStyling: true,
            svp: true,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadiusLarge),
              bottomLeft: Radius.circular(borderRadiusLarge),
            ),
            child: AppIcon(Icons.keyboard_arrow_left, size: extra, faded: true),
          ),
          //
          // AppSeparator(isVertical: true),
          // today
          Planet(
            onPressed: state.dates.date.isToday() ? () {} : () => goToToday(),
            tooltip: DateItem(now().format()).dateInfo(),
            noStyling: true,
            svp: true,
            radius: 0,
            child: AppText('Today'),
          ),
          //
          // AppSeparator(isVertical: true),
          // next date
          Planet(
            onPressed: () => swipeToNew(direction: 'right'),
            tooltip: 'Next',
            noStyling: true,
            svp: true,
            padding: padC('l8,r8,t3,b3'),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(borderRadiusLarge),
              bottomRight: Radius.circular(borderRadiusLarge),
            ),
            child: AppIcon(Icons.keyboard_arrow_right, size: extra, faded: true),
          ),
        ],
      ),
    );
  }
}
