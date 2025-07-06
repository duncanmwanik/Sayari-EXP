import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_helpers/nav/navigation.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/buttons/action.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/dialogs/app_dialog.dart';
import '../../../_widgets/others/checkbox.dart';
import '../../../_widgets/others/divider_vertical.dart';
import '../../../_widgets/others/list.dart';
import '../_helpers/save_settings.dart';
import '../state/pomodoro.dart';
import 'alarm_chooser.dart';
import 'setting.dart';

Future<void> showPomodoroSettingsDialog() async {
  Map previousdata = {...state.pomodoro.data};

  await showAppDialog(
    title: 'Settings',
    contentPadding: padM('lr'),
    content: Consumer<PomodoroProvider>(builder: (context, pomodoroProvider, child) {
      bool isAutoPlayOn = pomodoroProvider.data['ap'] == '1';
      bool isAlarmOn = pomodoroProvider.data['ao'] == '1';

      return AppScroll(
        children: [
          //
          PomodoroSetting(type: 'f'),
          //
          PomodoroSetting(type: 's'),
          //
          PomodoroSetting(type: 'l'),
          //
          msph(),
          Planet(
            onPressed: () => pomodoroProvider.updatedata('ap', isAutoPlayOn ? '0' : '1'),
            svp: true,
            srp: true,
            leading: 'Auto-Repeat',
            trailing: AppCheckBox(
              margin: padM('l'),
              isChecked: isAutoPlayOn,
              onTap: () => pomodoroProvider.updatedata('ap', isAutoPlayOn ? '0' : '1'),
            ),
            noStyling: true,
          ),
          //
          sph(),
          //
          Row(
            children: [
              Planet(
                onPressed: () => pomodoroProvider.updatedata('ao', isAlarmOn ? '0' : '1'),
                svp: true,
                srp: true,
                leading: 'Play Alarm',
                trailing: AppCheckBox(
                  margin: padM('l'),
                  isChecked: isAlarmOn,
                  onTap: () => pomodoroProvider.updatedata('ao', isAlarmOn ? '0' : '1'),
                ),
                noStyling: true,
              ),
              AppSeparator(),
              AlarmChooser(),
            ],
          ),
          //
          elph(),
          //
        ],
      );
    }),
    actions: [
      ActionButton(isCancel: true),
      ActionButton(label: 'Save', onPressed: () => popWhatsOnTop(value: true)),
    ],
  ).then((value) {
    if (value == true) {
      savePomodoroSettings(previousdata);
    } else {
      state.pomodoro.setdata(previousdata);
    }
  });
}
