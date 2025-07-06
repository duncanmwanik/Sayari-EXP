import 'package:flutter_tts/flutter_tts.dart';

import '../../../_helpers/debug/debug.dart';
import '../../../_state/_providers.dart';

TTSService ttsService = TTSService();

class TTSService {
  FlutterTts flutterTts = FlutterTts();

  Future<void> startTTS() async {
    try {
      String text = state.tts.textToSpeak;

      if (text.trim().isNotEmpty) {
        state.tts.updateIsPlaying(true);
        await flutterTts.speak(text);

        flutterTts.setCompletionHandler(() {
          state.tts.updateIsPlaying(false);
        });
      }
    } catch (e) {
      logError('start-tts', e);
    }
  }

  Future stopTTS() async {
    try {
      state.tts.updateIsPlaying(false);
      await flutterTts.stop();
      state.tts.updateIsPlaying(false);
    } catch (e) {
      logError('stop-tts', e);
    }
  }

  Future setSpeechRateTTS(int speechRate) async {
    try {
      await flutterTts.setSpeechRate(1.0);
    } catch (e) {
      logError('stop-tts', e);
    }
  }

  Future setVoiceTTS(int speechRate) async {
    try {
      await flutterTts.setVoice({});
    } catch (e) {
      logError('stop-tts', e);
    }
  }
}
