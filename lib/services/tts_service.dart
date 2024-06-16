import 'package:flutter_tts/flutter_tts.dart';
import 'dart:async';

class TtsService {
  final FlutterTts _flutterTts = FlutterTts();

  TtsService() {
    _configureTTS();
  }

  void _configureTTS() {
    _flutterTts.setLanguage("pt-BR");
    _flutterTts.setPitch(1.0);
  }

  Future<void> speak(String text) async {
    final Completer<void> completer = Completer<void>();

    _flutterTts.setCompletionHandler(() {
      completer.complete();
    });

    await _flutterTts.speak(text);
    return completer.future;
  }
}
