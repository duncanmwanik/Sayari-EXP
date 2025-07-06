import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_models/item.dart';
import '../../_state/input.dart';
import '../../_theme/spacing.dart';
import '../../_variables/constants.dart';
import '../calendar/views/monthly/month.dart';
import 'month_cell.dart';

class HabitMonth extends StatelessWidget {
  const HabitMonth({super.key, this.item});

  final Item? item;

  @override
  Widget build(BuildContext context) {
    bool isInput = item == null;

    return MonthBuilder(
      isInitials: !isInput,
      maxWidth: isInput ? 500 : null,
      spacing: tw(),
      showBorder: false,
      widget: (date, width, height) {
        String dateKey = '$itemSubItem${date.date}';

        if (isInput) {
          return Consumer<InputProvider>(builder: (x, input, w) {
            bool isChecked = input.item.isHabitChecked(dateKey);
            bool isCustomDate = input.item.customHabitDates().contains(date.date);

            return MonthCell(
              date: date,
              item: input.item,
              dateKey: dateKey,
              isChecked: isChecked,
              isSelectedMonth: date.isSelectedMonth(),
              isCustomDate: isCustomDate,
              isInput: isInput,
              width: width,
            );
          });
        } else {
          bool isChecked = item!.isHabitChecked(dateKey);
          bool isCustomDate = item!.customHabitDates().contains(date.date);

          return MonthCell(
            date: date,
            item: item,
            dateKey: dateKey,
            isChecked: isChecked,
            isSelectedMonth: date.isSelectedMonth(),
            isCustomDate: isCustomDate,
            isInput: isInput,
            width: width,
          );
        }
      },
    );
  }
}
