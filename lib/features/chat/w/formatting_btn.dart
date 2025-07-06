import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../_services/hive/boxes.dart';
import '../../../_theme/spacing.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';

class ChatFormarttingButton extends StatelessWidget {
  const ChatFormarttingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: globalBox.listenable(keys: ['chatShowToolbar']),
        builder: (context, box, child) {
          bool show = box.get('chatShowToolbar', defaultValue: false);

          return Planet(
            onPressed: () => box.put('chatShowToolbar', !show),
            noStyling: !show,
            tooltip: 'Formatting',
            isSquare: true,
            padding: padM(),
            child: AppIcon(Icons.format_size, faded: true),
          );
        });
  }
}
