import 'package:flutter/material.dart';

import '../../../../_models/date.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/others/future.dart';
import '../../../../_widgets/others/icons.dart';
import '../../../../_widgets/others/text.dart';
import '../../_helpers/prepare.dart';
import '../../_helpers/sort.dart';
import '../_w/all_sessions_menu.dart';

class YearDate extends StatelessWidget {
  const YearDate(
    this.date,
    this.isSelectedMonth,
    this.width, {
    super.key,
  });

  final DateItem date;
  final bool isSelectedMonth;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Planet(
        menu: sessionListMenu(date),
        onLongPress: isSelectedMonth ? () => createSession(date: date, hour: TimeOfDay.now().hour) : null,
        noStyling: true,
        isRound: true,
        showBorder: isSelectedMonth && date.isToday(),
        borderColor: styler.accent(),
        padding: noPadding,
        child: Stack(
          children: [
            // date
            Planet(
              width: width / 7.5,
              height: width / 7.5,
              padding: noPadding,
              dryWidth: true,
              noStyling: true,
              child: Center(
                child: AppText(
                  size: small,
                  date.isBad ? '-' : date.day().toString(),
                  color: date.isBad
                      ? styler.appColor(2)
                      : isSelectedMonth && date.isToday()
                          ? styler.accent()
                          : isSelectedMonth
                              ? null
                              : styler.appColor(2),
                ),
              ),
            ),
            // indicator: if date has sessions
            if (!date.isBad)
              AppFuture(
                  future: sortSessions(date),
                  widget: (sessions) {
                    return Visibility(
                      visible: sessions.isNotEmpty,
                      child: Positioned(
                        top: 4,
                        left: width / 16,
                        child: AppIcon(Icons.circle, size: 5, color: styler.accent()),
                      ),
                    );
                  }),
            //
          ],
        ));
  }
}
