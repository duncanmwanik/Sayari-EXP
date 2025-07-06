import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_theme/variables.dart';
import '../../_state/date.dart';
import 'date.dart';
import 'month.dart';

class MonthlyView extends StatelessWidget {
  const MonthlyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateProvider>(builder: (context, dates, child) {
      return Title(
        title: dates.date.monthInfo(),
        color: styler.accent(),
        child: MonthBuilder(
          widget: (date, width, height) => MonthDate(date, width, height),
        ),
      );
    });
  }
}
