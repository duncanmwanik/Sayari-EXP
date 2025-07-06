import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_state/input.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../../_widgets/menu/menu_item.dart';
import '../../_widgets/others/checkbox.dart';

class TaskOptions extends StatelessWidget {
  const TaskOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(builder: (context, input, child) {
      bool showCheckBoxes = input.item.showChecks();
      // bool showProgress = input.item.showProgress();
      bool addToTop = input.item.showNewEntriesFirst();

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //
          MenuItem(
            onTap: () => input.update(itemShowChecks, showCheckBoxes ? 0 : 1),
            label: 'Show Checkboxes',
            leading: AppCheckBox(isChecked: showCheckBoxes, size: medium),
            dyncamicLeading: true,
          ),
          //
          MenuItem(
            onTap: () => input.update(itemSortEntries, addToTop ? 0 : 1),
            label: 'Show Newer Items First',
            leading: AppCheckBox(isChecked: addToTop, size: medium),
            dyncamicLeading: true,
          ),
          //
        ],
      );
    });
  }
}
