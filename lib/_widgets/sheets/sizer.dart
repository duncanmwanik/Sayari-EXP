import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../_state/_providers.dart';
import '../../_theme/variables.dart';
import '../../features/notes/state/sheet.dart';
import '../buttons/planet.dart';
import '../others/icons.dart';

class SheetSizer extends StatelessWidget {
  const SheetSizer({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Visibility(
          visible: !state.views.isAlternateView(),
          child: Consumer<SheetProvider>(
            builder: (context, sheet, child) {
              return Planet(
                onPressed: () => sheet.updateIsMinimized(!sheet.isMin),
                tooltip: sheet.isMin ? 'Maximize' : 'Minimize',
                noStyling: true,
                isSquare: true,
                child: AppIcon(
                  sheet.isMin ? Icons.open_in_full : Icons.close_fullscreen,
                  size: normal,
                  faded: true,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
