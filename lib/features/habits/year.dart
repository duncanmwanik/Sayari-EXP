import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_state/_providers.dart';
import '../../_state/input.dart';
import '../../_variables/constants.dart';
import '../calendar/views/yearly/year.dart';
import 'month_cell.dart';

class HabitYear extends StatelessWidget {
  const HabitYear({super.key});

  @override
  Widget build(BuildContext context) {
    return YearBuilder(
      widget: (date, isSelectedMonth, width) {
        String dateKey = '$itemSubItem${date.date}';

        return Consumer<InputProvider>(builder: (x, input, w) {
          bool isChecked = input.item.isHabitChecked(dateKey);
          bool isCustomDate = input.item.customHabitDates().contains(date.date);

          return MonthCell(
            date: date,
            item: state.input.item,
            dateKey: dateKey,
            isChecked: isChecked,
            isSelectedMonth: isSelectedMonth,
            isCustomDate: isCustomDate,
            isInput: true,
            width: width,
          );
        });
      },
    );
  }
}
