import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_state/input.dart';
import '../../_theme/spacing.dart';
import '../spaces/new_space/date.dart';
import 'add.dart';
import 'entries.dart';
import 'totals.dart';

class Finance extends StatelessWidget {
  const Finance({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InputProvider>(
      builder: (context, input, child) {
        return Padding(
          padding: padM('t'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: msh(),
            children: [
              //
              FinanceTotals(),
              Dates(),
              AddEntry(),
              Entries(),
              spph(),
              //
            ],
          ),
        );
      },
    );
  }
}
