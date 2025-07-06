import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/text.dart';
import '_helpers/helpers.dart';
import 'state/pomodoro.dart';
import 'w/pause_play_btn.dart';

class PomodoroCounter extends StatelessWidget {
  const PomodoroCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PomodoroProvider>(builder: (context, pomo, child) {
      String type = pomo.currentTimer;
      Duration timer = Duration(minutes: int.parse(pomo.data['${type}t'] ?? '1'));
      int passedTime = (timer.inSeconds - pomo.remainingTime).toInt();
      bool isCounting = pomo.isCounting;
      Color color = styler.getBgColor(pomo.data['${type}c']) ?? styler.accent();

      return Padding(
        padding: padL('t'),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 300, maxHeight: 300),
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                //
                Planet(
                  height: 70.w,
                  width: 70.w,
                  customBorder: CircleBorder(),
                  padding: EdgeInsets.all(15),
                  color: styler.appColor(1),
                  noStyling: true,
                  child: Planet(
                    isSquare: true,
                    padding: EdgeInsets.all(16),
                    color: styler.appColor(0.5),
                    customBorder: CircleBorder(),
                    radius: borderRadiusCrazy,
                    child: CircularProgressIndicator(
                      strokeWidth: 12,
                      strokeCap: StrokeCap.round,
                      backgroundColor: color.withOpacity(0.2),
                      valueColor: AlwaysStoppedAnimation(color),
                      value: isCounting ? ((passedTime == timer.inSeconds ? 1 : passedTime) / timer.inSeconds) : 0,
                    ),
                  ),
                ),
                //
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // stopping time
                    SizedBox(
                      height: 30,
                      child: pomo.isCounting
                          ? AppText(
                              pomo.isCounting ? 'Stops at <b>${getStoppingTime()}</b>' : 'press play',
                              size: small,
                              color: styler.textColor(faded: true),
                            )
                          : Padding(
                              padding: padM('b'),
                              child: AppIcon(Icons.bolt, extraFaded: true),
                            ),
                    ),
                    // remaining Time
                    AppText(
                      size: 40,
                      getCounter(),
                      weight: FontWeight.w900,
                      faded: !isCounting,
                    ),
                    msph(),
                    // pause/play
                    PlayPauseTimer(),
                    //
                  ],
                )
                //
              ],
            ),
          ),
        ),
      );
    });
  }
}
