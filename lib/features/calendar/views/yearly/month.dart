import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../_helpers/common/global.dart';
import '../../../../_helpers/date_time/months.dart';
import '../../../../_helpers/extentions/date_time.dart';
import '../../../../_models/date.dart';
import '../../../../_state/_providers.dart';
import '../../../../_theme/spacing.dart';
import '../../../../_theme/variables.dart';
import '../../../../_widgets/others/future.dart';
import '../../../../_widgets/others/text.dart';
import '../monthly/header.dart';

class YearMonth extends StatelessWidget {
  const YearMonth({
    super.key,
    required this.indexMonth,
    required this.widget,
  });
  final int indexMonth;
  final Widget Function(DateItem, bool, double) widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 49.w,
      width: 47.w,
      padding: padM(),
      constraints: BoxConstraints(maxWidth: 250, maxHeight: 265),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadiusTiny),
      ),
      child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth;

        return Column(
          children: [
            // month title
            AppText(
              size: small,
              DateItem(DateTime(1999, indexMonth).format()).monthTitle(),
            ),
            tph(),
            // weekday titles
            MonthHeader(isInitials: true),
            //
            Flexible(
              child: AppFuture(
                future: getMonthDateMap(state.dates.date.year(), indexMonth),
                commonWidget: Column(
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: padC('t1'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(7, (indexDate) {
                          return widget(DateItem.bad(), false, width);
                        }),
                      ),
                    );
                  }),
                ),
                widget: (monthMap) => Column(
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: padC('t1'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(7, (indexDate) {
                          DateItem date = DateItem(monthMap[indexDate + (index * 7)] ?? now().datePart());
                          bool isSelectedMonth = date.month() == indexMonth;

                          return widget(date, isSelectedMonth, width);
                        }),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
