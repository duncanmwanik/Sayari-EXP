import 'package:flutter/material.dart';

import '../../../_helpers/common/helpers.dart';
import '../../../_models/item.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/others/divider_vertical.dart';
import '../../../_widgets/sheets/sizer.dart';
import '../actions/input.dart';

class DocHeader extends StatelessWidget {
  const DocHeader({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padC('r30,t1.75'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (!isShare()) CommonInputActions(),
          if (!state.views.isAlternateView()) AppSeparator(),
          SheetSizer(),
          AppSeparator(),
        ],
      ),
    );
  }
}
