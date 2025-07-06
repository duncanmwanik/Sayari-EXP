import 'package:flutter/material.dart';

import '../../../_theme/spacing.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';

class NoteFormarttingButton extends StatelessWidget {
  const NoteFormarttingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Planet(
      onPressed: () {},
      noStyling: true,
      tooltip: 'Formatting',
      margin: padM('l'),
      isSquare: true,
      child: AppIcon(Icons.format_size, faded: true),
    );
  }
}
