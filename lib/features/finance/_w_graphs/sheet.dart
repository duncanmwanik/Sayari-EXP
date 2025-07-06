import 'package:flutter/material.dart';

import '../../../_helpers/extentions/strings.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/buttons/close.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/text.dart';
import '../../../_widgets/sheets/sheet.dart';
import '../_helpers/calculations.dart';
import '../_helpers/helpers.dart';
import '../_vars/variables.dart';
import 'options.dart';
import 'pie.dart';

Future<void> showFinanceGraphsBottomSheet() async {
  double allAmounts = getAllAmounts(state.input.item);

  await showAppBottomSheet(
    header: Row(
      children: [
        Expanded(child: AppText('${state.input.item.data[itemTitle] ?? '-'}', weight: FontWeight.bold)),
        spw(),
        Planet(menu: graphMenu(), noStyling: true, faded: true, isSquare: true, leading: moreIcon),
        spw(),
        AppCloseButton(faded: true),
      ],
    ),
    //
    content: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // general stats
          AppPie(
            isLarge: true,
            label: 'General',
            data: [
              for (String type in financeTypes)
                {
                  'title':
                      '${type.financeTitle()}: ${formatThousands(getTotalAmount(state.input.item.data, type))}   ${((getTotalAmount(state.input.item.data, type) / allAmounts) * 100).toStringAsFixed(2)}%',
                  'color': type.financeColor(),
                  'value': (getTotalAmount(state.input.item.data, type) / allAmounts) * 100,
                },
            ],
          ),
          //
        ],
      ),
    ),
    //
  );
}
