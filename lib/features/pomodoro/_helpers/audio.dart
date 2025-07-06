import 'package:just_audio/just_audio.dart';

import '../../../_state/_providers.dart';

Future<void> playAudio(String name) async {
  if (state.pomodoro.data['ao'] == '1') {
    final player = AudioPlayer();
    await player.setAsset('assets/audio/$name.wav');
    player.play();
  }
}
