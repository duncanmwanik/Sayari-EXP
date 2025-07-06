import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../_models/date.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/others/text.dart';
import '../_w/all_sessions_menu.dart';
import 'all_sessions_btn.dart';

class MonthDateLabel extends StatelessWidget {
  const MonthDateLabel({
    super.key,
    required this.date,
  });

  final DateItem date;

  @override
  Widget build(BuildContext context) {
    bool isToday = date.isToday();
    bool isSelectedMonth = date.isSelectedMonth();

    return Align(
      alignment: Alignment.topRight,
      child: Planet(
        menu: sessionListMenu(date),
        padding: noPadding,
        minWidth: 20,
        minHeight: 20,
        noStyling: true,
        radius: 0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // date label
            AppText(
              size: small,
              '${(date.isToday() || date.day() == 1) ? date.monthTitleShort() : ''} ${date.day()}',
              weight: isToday
                  ? FontWeight.w600
                  : isSelectedMonth
                      ? null
                      : FontWeight.w100,
              extraFaded: !isSelectedMonth,
              color: isToday ? styler.accent() : null,
            ),
            // show all button
            MonthShowAllSessions(date: date)
            //
          ],
        ),
      ).animate().slideY(),
    );
  }
}
