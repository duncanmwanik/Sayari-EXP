import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_state/_providers.dart';
import '../../../_variables/features.dart';
import '../../../_widgets/others/scroll.dart';
import '../_state/date.dart';
import 'daily/daily.dart';
import 'monthly/monthly.dart';
import 'weekly/weekly.dart';
import 'yearly/yearly.dart';

class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  @override
  void initState() {
    state.dates.initCalendarView(features.calendar);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DateProvider>(builder: (x, dates, w) {
      return NoOverScroll(
        child: NoScrollBars(
          child: dates.isDay()
              ? DailyView()
              : dates.isWeek()
                  ? WeeklyView()
                  : dates.isMonth()
                      ? MonthlyView()
                      : YearlyView(),
        ),
      );
    });
  }
}
