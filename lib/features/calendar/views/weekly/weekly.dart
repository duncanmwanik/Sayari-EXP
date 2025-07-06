import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../_helpers/common/global.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/others/swipe_detector.dart';
import '../../_helpers/swipe.dart';
import '../../_state/date.dart';
import '../daily/hour.dart';
import 'day_labels.dart';
import 'sessions.dart';

class WeeklyView extends StatelessWidget {
  const WeeklyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateProvider>(builder: (context, dates, child) {
      return Title(
        title: dates.date.weekInfo(),
        color: styler.accent(),
        child: SwipeDetector(
          onSwipeRight: () => swipeToNew(isNext: false),
          onSwipeLeft: () => swipeToNew(isNext: true),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //
              WeekHeader(),
              //
              Flexible(
                child: ScrollablePositionedList.builder(
                    initialScrollIndex: now().hour,
                    shrinkWrap: true,
                    itemCount: 24,
                    padding: EdgeInsets.only(bottom: h15()),
                    itemBuilder: (BuildContext context, int indexHour) {
                      bool isCurrentHour = TimeOfDay.now().hour == indexHour;

                      return Planet(
                        radius: 0,
                        noStyling: true,
                        padding: noPadding,
                        borderSide: Border(top: BorderSide(color: styler.borderColor(), width: 0.3)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // hour
                            Hour(indexHour: indexHour, isCurrentHour: isCurrentHour),
                            // sessions
                            Expanded(
                              child: WeeklySessions(indexHour: indexHour, isCurrentHour: isCurrentHour),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
              //
            ],
          ),
        ),
      );
    });
  }
}
