import 'package:flutter/material.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../_services/hive/boxes.dart';
import '../../_theme/spacing.dart';
import '../../_widgets/buttons/planet.dart';
import '../../_widgets/others/icons.dart';
import '../notes/_helpers/misc.dart';
import '../share/w_shared/socials.dart';
import '../tts/_helpers/tts_service.dart';
import '../tts/_state/tts_provider.dart';
import '../user/_helpers/saved.dart';

class SharedActions extends StatelessWidget {
  const SharedActions({super.key, required this.id, required this.userId});

  final String id;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: sw(),
      runSpacing: sw(),
      crossAxisAlignment: WrapCrossAlignment.end,
      alignment: WrapAlignment.end,
      children: [
        // save
        ValueListenableBuilder(
            valueListenable: savedBox.listenable(),
            builder: (context, box, widget) {
              bool isSaved = box.containsKey(id);

              return Planet(
                onPressed: () => saveItem(id, isSaved),
                tooltip: isSaved ? 'Remove from saved' : 'Save',
                noStyling: true,
                isSquare: true,
                child: AppIcon(isSaved ? Icons.bookmark_remove : Icons.bookmark_add_outlined, faded: true),
              );
            }),
        // narrate
        Consumer<TTSProvider>(
          builder: (context, tts, child) => Planet(
            onPressed: () {
              tts.updateTextToSpeak(getEditorText());
              tts.isPlaying ? ttsService.stopTTS() : ttsService.startTTS();
            },
            tooltip: tts.isPlaying ? 'Stop Narration' : 'Narrate',
            noStyling: !tts.isPlaying,
            isSquare: true,
            child: AppIcon(tts.isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded, faded: true),
          ),
        ),
        // share
        ShareToSocials(title: '', link: ''),
        //
      ],
    );
  }
}
