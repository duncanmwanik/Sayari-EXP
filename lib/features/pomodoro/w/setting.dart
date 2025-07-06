import 'package:flutter/material.dart';

import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/forms/numeric.dart';
import '../../../_widgets/others/color.dart';
import '../../../_widgets/others/color_menu.dart';
import '../../../_widgets/others/text.dart';
import '../var/variables.dart';

class PomodoroSetting extends StatelessWidget {
  const PomodoroSetting({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Planet(
      showBorder: true,
      noStyling: true,
      margin: padMS('t'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // title
          AppText(pomodoroTitles[type] ?? '---', weight: ft6),
          sph(),
          //
          Flexible(
            child: Wrap(
              spacing: sw(),
              runSpacing: sw(),
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                // minutes input
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //
                    NumericFormInput(
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          state.pomodoro.updatedata('${type}t', value.trim().toString());
                        }
                      },
                      initialValue: state.pomodoro.data['${type}t'],
                      maxLength: 5,
                      hintText: '0',
                    ),
                    spw(),
                    AppText('Minutes'),
                    //
                  ],
                ),
                //
                ColorButton(
                  menu: colorMenu(
                    selectedColor: state.pomodoro.data['${type}c'],
                    onSelect: (newColor) => state.pomodoro.updatedata('${type}c', newColor),
                  ),
                  color: state.pomodoro.data['${type}c'],
                ),
                //
                if (type == 'l')
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //
                      AppText('Interval :'),
                      spw(),
                      NumericFormInput(
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            state.pomodoro.updatedata('lbi', value.trim().toString());
                          }
                        },
                        initialValue: '4',
                        maxLength: 1,
                        hintText: '4',
                      ),
                      //
                    ],
                  ),
                //
              ],
            ),
          ),
          //
        ],
      ),
    );
  }
}
