import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/date_time/jump_to_date.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_theme/breakpoints.dart';
import '../../../_theme/helpers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/dialogs/dialog_select_date.dart';
import '../../../_widgets/others/text.dart';
import '../_state/date.dart';
import 'buttons.dart';
import 'chooser.dart';

class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    super.key,
    this.padding,
  });

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Planet(
      noStyling: true,
      // showBorder: true,
      radius: borderRadiusLarge,
      color: styler.appColor(0.8),
      padding: padding ?? pad(p: 5),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //
          // description
          Consumer<DateProvider>(builder: (context, dates, child) {
            return Planet(
              onPressed: !isPhone()
                  ? null
                  : () => showDateDialog(
                        showTitle: false,
                        onSelect: (date) => popWhatsOnTop(todo: () => jumpToDate(date)),
                      ),
              menu: isPhone() ? null : jumpToDateMenu((date) => popWhatsOnTop(todo: () => jumpToDate(date))),
              tooltip: 'Jump To Date',
              noStyling: true,
              padding: noPadding,
              hoverColor: transparent,
              radius: borderRadiusLarge,
              child: AppText(
                size: 17,
                dates.isDay()
                    ? dates.date.dateInfo()
                    : dates.isYear()
                        ? dates.date.year().toString()
                        : dates.date.monthInfo(),
                weight: isLight() ? ft7 : ft8,
                padding: padMS('l'),
              ),
            ).animate().scaleY();
          }),
          //
          mspw(),
          // next/previous
          ChangeButtons(),
          // view chooser
          ViewChooser(),
          //
        ],
      ),
    );
  }
}
