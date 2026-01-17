class QuizQuestion {
  final String id;
  final String question;
  final List<String> options;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'].toString(), // ✅ FIX (INT → STRING)
      question: json['question'].toString(),
      options: (json['options'] as List)
          .map((e) => e.toString())
          .toList(),
    );
  }
}

class Quiz {
  final String quizId;
  final List<QuizQuestion> questions;

  Quiz({
    required this.quizId,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      quizId: json['quiz_id'].toString(), // ✅ SAFE
      questions: (json['questions'] as List)
          .map((q) => QuizQuestion.fromJson(q))
          .toList(),
    );
  }
}
