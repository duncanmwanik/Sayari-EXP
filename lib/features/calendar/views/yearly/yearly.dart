import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../_theme/variables.dart';
import '../../_state/date.dart';
import 'date.dart';
import 'year.dart';

class YearlyView extends StatelessWidget {
  const YearlyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DateProvider>(builder: (context, dates, child) {
      return Title(
        title: dates.date.year().toString(),
        color: styler.accent(),
        child: YearBuilder(
          widget: (date, isSelectedMonth, width) => YearDate(date, isSelectedMonth, width),
        ),
      );
    });
  }
}
