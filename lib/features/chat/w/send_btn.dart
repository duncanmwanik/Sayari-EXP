import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_state/input.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/editor/state/editor.dart';
import '../../../_widgets/others/icons.dart';
import '../_helpers/send.dart';

class SendMessageButton extends StatelessWidget {
  const SendMessageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<EditorProvider, InputProvider>(builder: (context, editor, input, child) {
      bool enabled = !editor.isEmpty || input.item.hasFiles() || 1 == 1;

      return Planet(
        onPressed: enabled ? () => sendMessage() : null,
        tooltip: 'Send',
        isRound: true,
        padding: padM(),
        radius: borderRadiusMedium - 6,
        child: AppIcon(Icons.arrow_forward_rounded, color: styler.accent()),
      );
    });
  }
}
