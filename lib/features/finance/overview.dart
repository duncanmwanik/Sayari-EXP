import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../_helpers/extentions/strings.dart';
import '../../_models/item.dart';
import '../../_state/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '_helpers/calculations.dart';
import '_helpers/helpers.dart';
import '_vars/variables.dart';

class FinanceOverview extends StatelessWidget {
  const FinanceOverview({super.key, required this.item});
  final Item item;

  @override
  Widget build(BuildContext context) {
    double maxAmount = [item.total(itemIncome), item.total(itemExpense), item.total(itemSaving)].max;

    return Padding(
      padding: padS('t'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          for (String type in financeTypes)
            Planet(
              margin: padT('tb'),
              padding: padC('l2,r4'),
              noStyling: true,
              borderColor: type.financeColor().withOpacity(0.4),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //
                  AppIcon(type.financeIcon(), size: mediumSmall, color: type.financeColor()),
                  // done icon
                  if (item.goal(type) > 0 && getTotalAmount(item.data, type) >= item.goal(type))
                    AppIcon(
                      Icons.verified,
                      size: mediumSmall,
                      color: type.financeColor(),
                      padding: padS('l'),
                    ),
                  tpw(),
                  Flexible(
                    child: AppText(
                      formatThousands(item.total(type)),
                      color: type.financeColor(),
                      weight: ft6,
                      textAlign: TextAlign.end,
                    ),
                  ),
                  //
                ],
              ),
            ),
          //
          mph(),
          LayoutBuilder(
            builder: (context, constraints) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // AppDivider(thickness: 0.2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (String type in financeTypes)
                        if (item.total(type) > 0)
                          Flexible(
                            child: Planet(
                              padding: noPadding,
                              showBorder: true,
                              color: type.financeColor().withOpacity(0.1),
                              borderColor: type.financeColor(),
                              width: 40,
                              radius: borderRadiusLarge,
                              height: item.total(type) / maxAmount * 150,
                            ),
                          ),
                    ],
                  ),
                ],
              );
            },
          ),
          //
          if (state.views.isColumn()) sph(),
          //
        ],
      ),
    );
  }
}
