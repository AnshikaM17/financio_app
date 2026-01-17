import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/lesson_model.dart';
import '../core/learning_api_service.dart';

enum LearningStep { topics, loading, lesson, quiz, result }

class LearningViewModel extends ChangeNotifier {
  LearningStep step = LearningStep.topics;

  final flutterTts = FlutterTts();

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

  Future<void> playVoice() async {
    await flutterTts.stop();
    await flutterTts.setLanguage('en-IN');
    await flutterTts.setSpeechRate(0.95);
    await flutterTts.speak(lesson!.voiceScript);
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
}
