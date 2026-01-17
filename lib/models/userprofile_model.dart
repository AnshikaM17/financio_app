class UserProfile {
  int totalXP;
  int streak;

  UserProfile({required this.totalXP, required this.streak});
}

class Lesson {
  final String id;
  final String titleEn;
  final String titleHi;

  Lesson({required this.id, required this.titleEn, required this.titleHi});
}
