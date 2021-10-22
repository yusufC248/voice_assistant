import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceApi{
  static final _speech = SpeechToText();

  static Future<bool> buttonRecording({
    required Function(String text) onResult,
    required ValueChanged<bool> onListening,
}) async {
    if(_speech.isListening){
      _speech.stop();
      return true;
    }

    final isAvailable = await _speech.initialize(
      onStatus: (status) => onListening(_speech.isListening),
      // ignore: avoid_print
      onError: (e) => print("Error: $e"),
    );

    if(isAvailable){
      _speech.listen(onResult: (value) => onResult(value.recognizedWords));
    }

    return isAvailable;
  }
}