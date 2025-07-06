import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_widgets/buttons/close.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/divider_vertical.dart';
import '../../_widgets/others/icons.dart';
import '../../_widgets/others/scroll.dart';
import '../../_widgets/others/text.dart';
import '../../_widgets/sheets/sheet.dart';
import '../../_widgets/sheets/sizer.dart';
import '../tasks/task_lists.dart';
import '_helpers/audio.dart';
import 'chooser.dart';
import 'counter.dart';
import 'w/settings_dialog.dart';

Future<void> showPomodoroSheet() async {
  await showAppBottomSheet(
    // showBlur: isDark(),
    header: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: padMS('l'),
          child: AppText('pomodoro', size: 20, weight: FontWeight.bold, faded: true),
        ),
        Spacer(),
        if (kDebugMode)
          Planet(
            onPressed: () => playAudio('woow'),
            noStyling: true,
            isSquare: true,
            margin: padM('r'),
            child: AppIcon(Icons.play_arrow, size: extra, faded: true),
          ),
        Planet(
          onPressed: () => showPomodoroSettingsDialog(),
          tooltip: 'Pomodoro Settings',
          noStyling: true,
          isSquare: true,
          child: AppIcon(settingsIcon, size: extra, faded: true),
        ),
        AppSeparator(),
        SheetSizer(),
        AppSeparator(),
        AppCloseButton(),
        //
      ],
    ),
    content: NoScrollBars(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //
            PomodoroChooser(),
            PomodoroCounter(),
            TaskLists(),
            //
          ],
        ),
      ),
    ),
    //
  );
}
