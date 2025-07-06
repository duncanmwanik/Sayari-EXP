import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_state/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../calendar/_state/date.dart';
import '../calendar/views/header.dart';
import 'month.dart';
import 'year.dart';

class Habit extends StatefulWidget {
  const Habit({super.key});

  @override
  State<Habit> createState() => _HabitState();
}

class _HabitState extends State<Habit> {
  @override
  void initState() {
    state.dates.initCalendarView(state.input.item.id, state.input.item.habitView());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DateProvider>(builder: (context, dates, child) {
      return Container(
        margin: padN('tb'),
        padding: padM(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            sph(),
            CalendarHeader(padding: noPadding),
            lph(),
            if (dates.isMonth()) HabitMonth(),
            if (dates.isYear()) HabitYear(),
            lph(),
            //
          ],
        ),
      );
    });
  }
}
