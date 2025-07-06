import 'package:flutter/material.dart';

import '../../../_models/item.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/others/text.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padS('l'),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // count
          Expanded(
              child: AppText(
            '${item.checkedCount()} / ${item.taskCount()}',
            size: tinySmall,
            faded: true,
          )),
          // progress
          SizedBox(
            height: tiny,
            width: tiny,
            child: CircularProgressIndicator(
              value: item.checkedCount() / item.taskCount(),
              backgroundColor: styler.accent(2),
              valueColor: AlwaysStoppedAnimation(styler.accent()),
              strokeCap: StrokeCap.round,
              strokeWidth: 3,
            ),
          ),
          tpw(),
          // percentage
          AppText(
            '${(item.checkedCount() / item.taskCount() * 100).truncate()}%',
            size: tinySmall,
            color: styler.accent(),
            weight: FontWeight.bold,
          ),
          //
        ],
      ),
    );
  }
}
