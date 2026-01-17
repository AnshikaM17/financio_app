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
      score: (json['score'] ?? 0) as int,        // ✅ NULL SAFE
      outOf: (json['out_of'] ?? 0) as int,       // ✅
      xpGained: (json['xp_gained'] ?? 0) as int, // ✅
      streak: (json['streak'] ?? 0) as int,      // ✅
      explanations: (json['explanations'] ?? [])
          .map<String>((e) => e.toString())
          .toList(),
    );
  }
}