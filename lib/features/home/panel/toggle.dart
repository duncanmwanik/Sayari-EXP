import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../_services/hive/boxes.dart';
import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/others/icons.dart';
import 'helpers.dart';

class PanelToggle extends StatelessWidget {
  const PanelToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: globalBox.listenable(keys: ['showPanelOptions']),
        builder: (context, box, w) {
          bool show = box.get('showPanelOptions', defaultValue: true);

          return Planet(
            onPressed: () => togglePanel(),
            tooltip: show ? 'Hide' : 'Pin',
            padding: padS(),
            noStyling: true,
            child: AppIcon(
              show ? Icons.keyboard_double_arrow_left : pinIcon,
              size: show ? extra : normal,
              rotation: show ? 0 : 30,
              extraFaded: true,
            ),
          );
        });
  }
}
