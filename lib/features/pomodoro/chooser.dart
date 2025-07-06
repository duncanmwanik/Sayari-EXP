import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/planet.dart';
import 'state/pomodoro.dart';
import 'type.dart';

class PomodoroChooser extends StatelessWidget {
  const PomodoroChooser({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroProvider>(builder: (context, pomo, child) {
      return Planet(
        margin: padL('tb'),
        padding: padS(),
        radius: borderRadiusLarge,
        child: Wrap(
          spacing: tw(),
          runSpacing: tw(),
          children: [
            // focus
            PomodoroType(type: 'f'),
            // short break
            PomodoroType(type: 's'),
            // long break
            PomodoroType(type: 'l'),
            //
          ],
        ),
      );
    });
  }
}
