import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/lesson_model.dart';
import '../core/learning_api_service.dart';

enum LearningStep { topics, loading, lesson, quiz, result }

class LearningViewModel extends ChangeNotifier {
  LearningStep step = LearningStep.topics;

  final FlutterTts flutterTts = FlutterTts();

  Lesson? lesson;
  String level = 'beginner';
  String? selectedTopic;

  final Map<int, int> answers = {};
  int score = 0;

  final topics = const [
    {'title': 'Compound Interest', 'desc': 'Grow your money'},
    {'title': 'UPI', 'desc': 'Digital payments'},
    {'title': 'Government Schemes', 'desc': 'Public benefits'},
    {'title': 'Fraud Awareness', 'desc': 'Stay safe online'},
  ];

  Future<void> startLesson(String topic) async {
    selectedTopic = topic;
    step = LearningStep.loading;
    notifyListeners();

    await LearningApiService.generateLesson(
      topic: topic,
      level: level,
    );

    lesson = await LearningApiService.loadLesson(
      topic: topic,
      level: level,
    );

    step = LearningStep.lesson;
    notifyListeners();
  }

  /// 🔊 SAFE TTS (NO CRASH)
  Future<void> playVoice() async {
    if (lesson == null) return;

    try {
      await flutterTts.setLanguage('en-IN');
      await flutterTts.setSpeechRate(0.6);
      await flutterTts.speak(lesson!.voiceScript);
    } catch (e) {
      debugPrint('TTS error: $e');
    }
  }

  Future<void> stopVoice() async {
  try {
    await flutterTts.stop();
  } catch (e) {
    debugPrint('TTS stop error: $e');
  }
}


  void submitQuiz() {
    score = 0;
    lesson!.quiz.asMap().forEach((i, q) {
      if (answers[i] == q.correctIndex) score++;
    });

    step = LearningStep.result;
    notifyListeners();
  }

  void reset() {
    lesson = null;
    answers.clear();
    score = 0;
    step = LearningStep.topics;
    notifyListeners();
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }
}
