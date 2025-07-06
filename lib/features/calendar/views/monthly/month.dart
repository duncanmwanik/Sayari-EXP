import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_helpers/date_time/months.dart';
import '../../../../_models/date.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/buttons/planet.dart';
import '../../../../_widgets/others/future.dart';
import '../../../../_widgets/others/scroll.dart';
import '../../../../_widgets/others/swipe_detector.dart';
import '../../_helpers/swipe.dart';
import '../../_state/date.dart';
import 'header.dart';

class MonthBuilder extends StatelessWidget {
  const MonthBuilder({
    super.key,
    this.maxWidth,
    this.spacing = 0.0,
    this.isInitials = false,
    this.showBorder = true,
    required this.widget,
  });

  final double? maxWidth;
  final double spacing;
  final bool isInitials;
  final bool showBorder;
  final Widget Function(DateItem, double, double) widget;

  @override
  Widget build(BuildContext context) {
    return Consumer<DateProvider>(builder: (context, dates, child) {
      return SwipeDetector(
        onSwipeRight: () => swipeToNew(isNext: false),
        onSwipeDown: () => swipeToNew(isNext: false),
        onSwipeLeft: () => swipeToNew(isNext: true),
        onSwipeUp: () => swipeToNew(isNext: true),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            MonthHeader(isInitials: isInitials),
            //
            Flexible(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  double height = constraints.maxHeight;
                  double width = maxWidth ?? constraints.maxWidth;

                  return NoScrollBars(
                    child: SingleChildScrollView(
                      child: AppFuture(
                        future: getMonthDateMap(dates.date.year(), dates.date.month()),
                        commonWidget: Column(
                          children: List.generate(6, (index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(7, (_) {
                                return widget(DateItem.bad(), width, height);
                              }),
                            );
                          }),
                        ),
                        widget: (monthMap) => Column(
                          spacing: spacing,
                          children: List.generate(6, (index) {
                            return Planet(
                              radius: 0,
                              noStyling: true,
                              padding: noPadding,
                              borderSide: showBorder ? Border(top: BorderSide(color: styler.borderColor(), width: 0.3)) : null,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: List.generate(7, (indexDate) {
                                  return Planet(
                                    radius: 0,
                                    noStyling: true,
                                    padding: noPadding,
                                    borderSide: showBorder ? Border(right: BorderSide(color: styler.borderColor(), width: 0.3)) : null,
                                    child: widget(DateItem(monthMap[indexDate + (index * 7)]!), width, height),
                                  );
                                }),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            //
          ],
        ),
      );
    });
  }
}
