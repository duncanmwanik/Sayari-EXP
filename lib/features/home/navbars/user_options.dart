import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/toast.dart';
import '../../pomodoro/sheet.dart';

class UserOptions extends StatelessWidget {
  const UserOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        //
        // if (showNavItem(feature.pomodoro)) mph(),
        // if (showNavItem(feature.pomodoro))
        Planet(
          onPressed: () => showPomodoroSheet(),
          tooltip: 'Pomodoro',
          tooltipDirection: AxisDirection.right,
          isSquare: true,
          noStyling: true,
          child: AppIcon(Icons.timer, extraFaded: true),
        ),
        //
        if (kDebugMode) mph(),
        if (kDebugMode)
          Planet(
            onPressed: () => toastSuccess('Hey...'),
            tooltipDirection: AxisDirection.right,
            isSquare: true,
            noStyling: true,
            child: AppIcon(Icons.help, extraFaded: true),
          ),
        //
      ],
    );
  }
}
