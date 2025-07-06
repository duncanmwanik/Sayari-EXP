import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_helpers/extentions/strings.dart';
import '../../_state/_providers.dart';
import '../../_state/input.dart';
import '../../_theme/helpers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/text.dart';
import '_helpers/calculations.dart';
import '_helpers/helpers.dart';
import '_vars/variables.dart';
import '_w_graphs/sheet.dart';

class FinanceTotals extends StatelessWidget {
  const FinanceTotals({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      return Row(
        spacing: sw(),
        children: [
          //
          for (String type in financeTypes)
            Expanded(
              child: Planet(
                onPressed: () => showFinanceGraphsBottomSheet(),
                color: type.financeColor().withOpacity(isDarkOnly() ? 0.06 : 0.1),
                slp: true,
                showBorder: true,
                borderColor: type.financeColor(),
                borderWidth: 0.3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(type.financesTitle(), size: tiny, weight: ft6, faded: true),
                    AppText(
                      size: extra,
                      formatThousands(getTotalAmount(state.input.item.data, type)),
                      weight: ft7,
                      color: type.financeColor(),
                    ),
                  ],
                ),
              ),
            ),
          //
        ],
      );
    });
  }
}
