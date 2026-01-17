class LearningQuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  LearningQuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
  });

  factory LearningQuizQuestion.fromJson(Map<String, dynamic> json) {
    return LearningQuizQuestion(
      question: json['question'],
      options: List<String>.from(json['options']),
      correctIndex: json['correct_index'],
      explanation: json['explanation'],
    );
  }
}