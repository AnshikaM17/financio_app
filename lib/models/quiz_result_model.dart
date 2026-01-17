class QuizResult {
  final int score;
  final int outOf;
  final int xpGained;
  final int streak;
  final List<String> explanations;

  QuizResult({
    required this.score,
    required this.outOf,
    required this.xpGained,
    required this.streak,
    required this.explanations,
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      score: json['score'],
      outOf: json['out_of'],
      xpGained: json['xp_gained'],
      streak: json['streak'],
      explanations:
          (json['explanations'] as List).map((e) => e.toString()).toList(),
    );
  }
}
