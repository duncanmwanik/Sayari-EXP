import 'package:flutter/material.dart';

import '../../_helpers/common/global.dart';
import '../../_models/date.dart';
import '../../_models/item.dart';
import '../../_services/cloud/sync/quick_edit.dart';
import '../../_state/_providers.dart';
import '../../_theme/helpers.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';

class MonthCell extends StatelessWidget {
  const MonthCell({
    super.key,
    required this.date,
    required this.item,
    required this.dateKey,
    required this.isChecked,
    required this.isSelectedMonth,
    required this.isCustomDate,
    required this.isInput,
    required this.width,
  });

  final DateItem date;
  final Item? item;
  final String dateKey;
  final bool isChecked;
  final bool isSelectedMonth;
  final bool isCustomDate;
  final bool isInput;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Planet(
      onPressed: () {
        if (isInput) {
          isChecked
              ? state.input.remove(dateKey)
              : state.input.update(
                  dateKey,
                  getUniqueId(),
                );
        } else {
          quickEdit(
            action: isChecked ? 'd' : 'c',
            parent: item!.parent,
            id: item!.id,
            key: isChecked ? dateKey : dateKey,
            value: getUniqueId(),
          );
        }
      },
      width: width / 8,
      height: width / 8,
      isRound: true,
      padding: noPadding,
      noStyling: !isInput || !isSelectedMonth,
      color: isChecked ? styler.accent(0.6) : styler.appColor(isLight() ? 0.6 : 0.3),
      showBorder: isChecked,
      borderColor: isSelectedMonth ? styler.accent() : null,
      child: Stack(
        children: [
          //
          if (isChecked)
            Align(
              alignment: Alignment.topRight,
              child: AppIcon(
                Icons.verified,
                size: width / 24,
                color: isSelectedMonth ? styler.accent() : null,
                extraFaded: !isSelectedMonth,
              ),
            ),
          //
          Center(
            child: AppText(
              date.day().toString(),
              size: isInput ? medium : small,
              color: date.isToday() ? styler.accent() : null,
              weight: isChecked ? ft6 : (date.isToday() ? ft7 : ft4),
              extraFaded: date.isBad || !isSelectedMonth,
            ),
          ),
          //
        ],
      ),
    );
  }
}
