import 'package:flutter/material.dart';

import '../../_helpers/common/global.dart';
import '../../_helpers/extentions/strings.dart';
import '../../_models/item.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '_vars/variables.dart';
import 'add_entry.dart';
import 'add_menu.dart';
import 'filter.dart';

class AddEntry extends StatelessWidget {
  const AddEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //
        Flexible(
          child: Wrap(
            spacing: sw(),
            runSpacing: sw(),
            children: [
              //
              for (String type in [itemIncome, itemExpense, itemSaving])
                Planet(
                  onPressed: () => showFinanceEntryDialog(
                    Item(
                      isNew: true,
                      id: '$itemSubItem$type${getUniqueId()}',
                      type: type,
                      data: {
                        itemType: type.isIncome()
                            ? financeIncomeTypes.keys.first
                            : type.isExpense()
                                ? financeExpenseTypes.keys.first
                                : financeSavingTypes.keys.first,
                      },
                    ),
                  ),
                  slp: true,
                  svp: true,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppIcon(Icons.add_rounded, color: type.financeColor(), size: 18),
                      tpw(),
                      Flexible(
                        child: AppText(type.financeTitle(), color: type.financeColor()),
                      ),
                    ],
                  ),
                ),
              //
              Planet(
                menu: addEntryMenu(),
                slp: true,
                svp: true,
                noStyling: true,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppIcon(moreIcon, size: extra, faded: true),
                  ],
                ),
              ),
              //
            ],
          ),
        ),
        //
        EntriesFilter(),
        //
      ],
    );
  }
}
