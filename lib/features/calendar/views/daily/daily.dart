import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../_helpers/common/global.dart';
import '../../../../_services/hive/store.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_variables/features.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/others/swipe_detector.dart';
import '../../_helpers/prepare.dart';
import '../../_helpers/swipe.dart';
import '../../_state/date.dart';
import 'hour.dart';
import 'sessions.dart';

class DailyView extends StatelessWidget {
  const DailyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateProvider>(builder: (context, dates, child) {
      return Title(
        title: dates.date.dateInfo(),
        color: styler.accent(),
        child: ValueListenableBuilder(
            valueListenable: local(features.calendar).listenable(),
            builder: (context, box, widget) {
              return SwipeDetector(
                onSwipeRight: () => swipeToNew(isNext: false),
                onSwipeLeft: () => swipeToNew(isNext: true),
                child: ScrollablePositionedList.builder(
                  initialScrollIndex: now().hour,
                  shrinkWrap: true,
                  itemCount: 24,
                  padding: EdgeInsets.only(bottom: h15()),
                  itemBuilder: (BuildContext context, int indexHour) {
                    bool isCurrentHour = now().hour == indexHour;

                    return Planet(
                      onPressed: () => createSession(date: dates.date, hour: indexHour),
                      onDoublePress: () => createSession(date: dates.date, hour: indexHour),
                      onLongPress: () => createSession(date: dates.date, hour: indexHour),
                      mouseCursor: SystemMouseCursors.basic,
                      padding: padC('l3,r3,b5'),
                      noStyling: true,
                      minHeight: 40,
                      hoverColor: transparent,
                      color: isCurrentHour ? styler.accent(0.5) : transparent,
                      borderRadius: BorderRadius.zero,
                      borderSide: Border(
                        top: indexHour != 0
                            ? BorderSide(
                                color: isCurrentHour && dates.date.isToday() ? styler.accent() : styler.borderColor(),
                                width: 0.3,
                              )
                            : BorderSide.none,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // hour label
                          Hour(indexHour: indexHour, isCurrentHour: isCurrentHour, showTopBorder: false),
                          // sessions
                          Expanded(
                            child: DailySessions(date: dates.date, indexHour: indexHour),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
      );
    });
  }
}
