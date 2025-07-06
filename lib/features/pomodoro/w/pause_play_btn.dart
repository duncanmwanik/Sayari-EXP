import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../_helpers/helpers.dart';
import '../state/pomodoro.dart';

class PlayPauseTimer extends StatelessWidget {
  const PlayPauseTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroProvider>(builder: (context, pomo, child) {
      return Wrap(
        spacing: sw(),
        children: [
          // reset
          Planet(
            onPressed: pomo.isCounting
                ? () {
                    pomo.reset();
                    playPauseTimer(pomo.currentTimer);
                  }
                : null,
            tooltip: 'Restart',
            isRound: true,
            noStyling: true,
            child: AppIcon(Icons.restart_alt, extraFaded: !pomo.isCounting),
          ),
          // pause/play
          Planet(
            onPressed: () => playPauseTimer(pomo.currentTimer),
            tooltip: pomo.isPaused ? 'Resume' : 'Pause',
            isRound: true,
            color: white,
            child: AppIcon(
              !pomo.isCounting || pomo.isPaused ? Icons.play_arrow_rounded : Icons.pause_rounded,
              color: black,
            ),
          ),
          // reset
          Planet(
            onPressed: pomo.isCounting ? () => pomo.reset() : null,
            tooltip: 'Stop',
            isRound: true,
            noStyling: true,
            child: AppIcon(Icons.stop, extraFaded: !pomo.isCounting),
          ),
        ],
      );
    });
  }
}
