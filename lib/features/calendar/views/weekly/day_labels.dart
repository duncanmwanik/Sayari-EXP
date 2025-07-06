import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';

import '../../../../_models/date.dart';
import '../../../../_theme/breakpoints.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/others/text.dart';
import '../../_state/date.dart';
import '../../_var/date_time.dart';
import '../_w/all_sessions_menu.dart';

class WeekHeader extends StatelessWidget {
  const WeekHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateProvider>(
      builder: (context, dates, child) {
        DateItem date = DateItem(dates.weekDates[3]);

        return Row(
          children: [
            // Week No
            SizedBox(
              width: 45,
              child: AppText(
                date.weekNo().toString(),
                faded: true,
                weight: FontWeight.w600,
                textAlign: TextAlign.center,
              ),
            ),
            // Week Days
            Expanded(
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(weekDaysList.length, (index) {
                    DateItem date = DateItem(dates.weekDates[index]);

                    return Expanded(
                      child: Planet(
                        menu: sessionListMenu(date),
                        noStyling: true,
                        padding: padS(),
                        child: Flex(
                          direction: isSmallPC() ? Axis.horizontal : Axis.vertical,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Day Name
                            Flexible(
                              child: AppText(
                                size: small,
                                weekDaysList[index].shortName,
                                faded: !date.isToday(),
                              ),
                            ),
                            date.isToday() ? tpw() : pw(1),
                            // Date No
                            Container(
                              height: 22,
                              width: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: date.isToday() ? styler.accent() : Colors.transparent,
                              ),
                              child: Center(
                                child: AppText(
                                  size: small,
                                  date.day().toString(),
                                  color: date.isToday() ? white : null,
                                  weight: FontWeight.w400,
                                  faded: !date.isToday(),
                                ),
                              ),
                            ),
                            //
                          ],
                        ),
                      ).animate().slideY(),
                    );
                  }),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
