import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_theme/colors.dart';
import '../../_theme/helpers.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/text.dart';
import 'state/pomodoro.dart';
import 'var/variables.dart';

class PomodoroType extends StatelessWidget {
  const PomodoroType({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroProvider>(builder: (context, pomo, child) {
      bool isCurrent = pomo.currentTimer == type;

      return Planet(
        onPressed: () => pomo.reset(type),
        width: 120,
        radius: borderRadiusLarge,
        color: isCurrent ? backgroundColors[pomo.data['${type}c']]!.color : styler.appColor(0.5),
        child: AppText(
          pomodoroTitles[type] ?? 'focus',
          faded: !isCurrent,
          color: !isDark() && isCurrent ? white : null,
          weight: isCurrent ? FontWeight.w600 : FontWeight.w500,
          textAlign: TextAlign.center,
        ),
      );
    });
  }
}
