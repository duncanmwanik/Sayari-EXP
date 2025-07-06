import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_theme/colors.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/svg.dart';
import '../sheet.dart';
import '../state/pomodoro.dart';

class PomodoroIndicator extends StatefulWidget {
  const PomodoroIndicator({
    super.key,
    this.alwaysVisible = false,
  });

  final bool alwaysVisible;

  @override
  State<PomodoroIndicator> createState() => _PomodoroIndicatorState();
}

class _PomodoroIndicatorState extends State<PomodoroIndicator> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroProvider>(builder: (context, pomo, child) {
      String type = pomo.currentTimer;
      Duration timer = Duration(minutes: int.parse(pomo.data['${type}t'] ?? '1'));
      int passedTime = (timer.inSeconds - pomo.remainingTime).toInt();
      bool isCounting = pomo.isCounting;
      Color color = backgroundColors[pomo.data['${type}c']]!.color;

      return Visibility(
        visible: widget.alwaysVisible || pomo.isCounting,
        child: Planet(
          onPressed: () => showPomodoroSheet(),
          tooltip: 'Pomodoro',
          noStyling: true,
          isRound: true,
          // maxWidth: 30,
          // maxHeight: 30,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              //
              AppSvg(
                'tomato',
                size: extra,
                color: pomo.isCounting ? backgroundColors[pomo.data['${pomo.currentTimer}c']]!.color : null,
                faded: true,
              ),
              //
              if (1 == 2)
                Padding(
                  padding: padC('t4'),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      strokeCap: StrokeCap.round,
                      backgroundColor: color.withOpacity(0.9),
                      valueColor: AlwaysStoppedAnimation(backgroundColors[pomo.data['${pomo.currentTimer}c']]!.color),
                      value: isCounting ? ((passedTime == timer.inSeconds ? 1 : passedTime) / timer.inSeconds) : 0,
                    ),
                  ),
                ),
              //
            ],
          ),
        ),
      );
    });
  }
}
