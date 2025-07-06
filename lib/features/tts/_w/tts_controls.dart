import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../_theme/spacing.dart';
import '../../../_theme/variables.dart';
import '../../../_widgets/buttons/planet.dart';
import '../../../_widgets/menu/menu_item.dart';
import '../../../_widgets/menu/model.dart';
import '../../../_widgets/others/icons.dart';
import '../../../_widgets/others/text.dart';
import '../_state/tts_provider.dart';

class TTSControls extends StatelessWidget {
  const TTSControls({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TTSProvider>(builder: (context, ttsProvider, child) {
      String selectedVoice = ttsProvider.selectedVoice;

      return Row(
        children: [
          //
          Planet(
            tooltip: 'Change Voice',
            menu: Menu(
              items: List.generate(
                4,
                (index) => MenuItem(
                  label: 'Karen',
                  trailing: ttsProvider.selectedVoice == selectedVoice ? Icons.done_rounded : null,
                  onTap: () async => ttsProvider.updateSelectedVoice('voice'),
                ),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // selected voice
                Flexible(child: AppText('Karen')),
                spw(),
                AppIcon(dropIcon),
                //
              ],
            ),
          ),

          //
        ],
      );
    });
  }
}
