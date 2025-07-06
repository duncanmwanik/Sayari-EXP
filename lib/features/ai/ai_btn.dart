import 'package:flutter/material.dart';

import '../../_theme/spacing.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/icons.dart';
import 'ai_sheet.dart';

class AIButton extends StatelessWidget {
  const AIButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padM('r'),
      child: Planet(
        onPressed: () => showAISheet(),
        tooltip: 'AI Prompt',
        isSquare: true,
        noStyling: true,
        child: AppIcon(Icons.blur_on, faded: true),
      ),
    );
  }
}
