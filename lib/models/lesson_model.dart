import 'package:financio_app/models/question_model.dart';

class Lesson {
  final String title;
  final String voiceScript;
  final List<LearningQuizQuestion> quiz;

  Lesson({
    required this.title,
    required this.voiceScript,
    required this.quiz,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      title: json['title'],
      voiceScript: json['voice_script'],
      quiz: (json['quiz'] as List)
          .map((e) => LearningQuizQuestion.fromJson(e))
          .toList(),
    );
  }
}
