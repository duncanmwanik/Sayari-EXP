import 'package:flutter/material.dart';

import '../../_helpers/extentions/strings.dart';
import '../../_state/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/menu/menu_item.dart';
import '../../_widgets/menu/model.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';

class EntriesFilter extends StatelessWidget {
  const EntriesFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Planet(
      tooltip: 'Filter',
      menu: Menu(
        items: [
          //
          MenuItem(
            label: 'All',
            leading: Icons.all_inclusive,
            trailing: state.input.item.sortType() == itemSortAll ? Icons.done : null,
            isSelected: state.input.item.sortType() == itemSortAll,
            onTap: () => state.input.update(itemSortEntries, itemSortAll),
          ),
          //
          MenuItem(
            label: 'Incomes',
            leading: Icons.add,
            trailing: state.input.item.sortType() == itemIncome ? Icons.done : null,
            isSelected: state.input.item.sortType() == itemIncome,
            onTap: () => state.input.update(itemSortEntries, itemIncome),
          ),
          //
          MenuItem(
            label: 'Expenses',
            leading: Icons.remove,
            trailing: state.input.item.sortType() == itemExpense ? Icons.done : null,
            isSelected: state.input.item.sortType() == itemExpense,
            onTap: () => state.input.update(itemSortEntries, itemExpense),
          ),
          //
          MenuItem(
            label: 'Savings',
            leading: Icons.savings,
            trailing: state.input.item.sortType() == itemSaving ? Icons.done : null,
            isSelected: state.input.item.sortType() == itemSaving,
            onTap: () => state.input.update(itemSortEntries, itemSaving),
          ),
          //
        ],
      ),
      svp: true,
      srp: true,
      noStyling: true,
      margin: padM('l'),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: AppText(
              state.input.item.isSortAll() ? itemSortAllTitle : state.input.item.sortType().financeTitle(),
            ),
          ),
          tpw(),
          AppIcon(dropIcon, size: normal),
        ],
      ),
    );
  }
}
