import 'package:flutter/material.dart';

import '../../_helpers/extentions/strings.dart';
import '../../_state/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '_helpers/calculations.dart';
import '_helpers/helpers.dart';
import 'set_goal.dart';

class Goal extends StatelessWidget {
  const Goal(this.type, {super.key});

  final String type;

  @override
  Widget build(BuildContext context) {
    double goal = state.input.item.goal(type);
    bool hasGoal = goal > 0;
    bool isMet = hasGoal && getTotalAmount(state.input.item.data, type) >= goal;

    return Planet(
      onPressed: () => showSetGoalDialog(type),
      slp: !hasGoal,
      srp: isMet,
      radius: borderRadiusLarge,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // no goal
          // set goal
          if (!hasGoal) AppIcon(Icons.add_rounded, size: extra, padding: padS('r')),
          if (!hasGoal)
            Flexible(
              child: AppText(
                'Set ${type.financeTitle()} Goal',
                color: type.financeColor(),
              ),
            ),
          // has goal
          // goal text
          if (hasGoal)
            Flexible(
              child: AppText(
                '${type.financeTitle()} Goal: <b>${formatThousands(goal)}</b>',
                color: type.financeColor(),
              ),
            ),
          // percentage
          if (hasGoal)
            AppText(
              '  •  ${(getTotalAmount(state.input.item.data, type) / goal * 100).truncate()}%',
              color: type.financeColor(),
              weight: ft6,
            ),
          // done icon
          if (hasGoal && isMet)
            AppIcon(
              Icons.verified,
              size: extra,
              color: type.financeColor(),
              padding: padM('l'),
            ),
        ],
      ),
    );
  }
}
