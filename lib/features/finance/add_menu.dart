import 'package:flutter/material.dart';

import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_widgets/menu/menu_item.dart';
import '../../_widgets/menu/model.dart';
import 'set_goal.dart';

Menu addEntryMenu() {
  return Menu(
    items: [
      //
      MenuItem(
        leading: addIcon,
        label: 'Add Income Goal',
        onTap: () => showSetGoalDialog(itemIncome),
      ),
      //
      MenuItem(
        leading: addIcon,
        label: 'Add Saving Goal',
        onTap: () => showSetGoalDialog(itemSaving),
      ),
      //
      MenuItem(
        leading: addIcon,
        label: 'Add Expense Limit',
        onTap: () => showSetGoalDialog(itemExpense),
      ),
      //
      MenuItem(
        leading: Icons.remove,
        label: 'Withdraw from Saving',
        onTap: () => showSetGoalDialog(itemIncome),
      ),
      //
    ],
  );
}
