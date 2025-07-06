import 'package:flutter/material.dart';

import '../../../_helpers/extentions/strings.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/_widgets.dart';
import '../../notes/w/picker_type.dart';
import '../_helpers/audio.dart';
import '../var/variables.dart';

class AlarmChooser extends StatelessWidget {
  const AlarmChooser({super.key});

  @override
  Widget build(BuildContext context) {
    return AppTypePicker(
      onSelect: (chosenType, chosenValue) => popWhatsOnTop(todo: () => state.pomodoro.updatedata('as', chosenValue)),
      initial: state.pomodoro.data['as'].toString().cap(),
      typeEntries: audioMap,
      secondary: (chosenType, chosenValue) => Planet(
        onPressed: () => playAudio(chosenValue),
        padding: padS(),
        noStyling: true,
        child: AppIcon(Icons.play_arrow, size: normal, extraFaded: true),
      ),
    );
  }
}
