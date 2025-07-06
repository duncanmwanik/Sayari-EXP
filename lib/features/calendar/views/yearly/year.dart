import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../_models/date.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_variables/features.dart';
import '../../../../_widgets/others/scroll.dart';
import '../../../../_widgets/others/swipe_detector.dart';
import '../../_helpers/swipe.dart';
import '../../_state/date.dart';
import 'month.dart';

class YearBuilder extends StatelessWidget {
  const YearBuilder({
    super.key,
    required this.widget,
  });

  final Widget Function(DateItem, bool, double) widget;

  @override
  Widget build(BuildContext context) {
    return Consumer<DateProvider>(builder: (context, dates, child) {
      return SwipeDetector(
        onSwipeRight: () => swipeToNew(isNext: false),
        onSwipeLeft: () => swipeToNew(isNext: true),
        child: Align(
          alignment: Alignment.topCenter,
          child: NoScrollBars(
            child: SingleChildScrollView(
              padding: pad(
                t: medium,
                b: dates.calendarId.isCalendar() ? h10() : null,
              ),
              child: Wrap(
                spacing: 1.w,
                runSpacing: 1.w,
                children: List.generate(12, (index) {
                  return YearMonth(indexMonth: index + 1, widget: widget);
                }),
              ),
            ),
          ),
        ),
      );
    });
  }
}
