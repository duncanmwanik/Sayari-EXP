import 'package:flutter/material.dart';

import '../../_theme/spacing.dart';
import '../../_variables/constants.dart';
import 'goal.dart';

class Goals extends StatelessWidget {
  const Goals({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padM('t'),
      child: Wrap(
        spacing: sw(),
        runSpacing: sw(),
        children: [
          //
          Goal(itemIncome),
          Goal(itemExpense),
          Goal(itemSaving),
          //
        ],
      ),
    );
  }
}
