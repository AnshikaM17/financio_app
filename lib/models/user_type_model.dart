enum UserType {
  farmer,
  business,
  worker,
  homemaker,
}

class UserTypeModel {
  final UserType type;
  final String emoji;
  final String translationKey;

  UserTypeModel({
    required this.type,
    required this.emoji,
    required this.translationKey,
  });

  static List<UserTypeModel> getUserTypes() {
    return [
      UserTypeModel(
        type: UserType.farmer,
        emoji: '🌾',
        translationKey: 'farmer',
      ),
      UserTypeModel(
        type: UserType.business,
        emoji: '🏪',
        translationKey: 'business',
      ),
      UserTypeModel(
        type: UserType.worker,
        emoji: '👷',
        translationKey: 'worker',
      ),
      UserTypeModel(
        type: UserType.homemaker,
        emoji: '🏠',
        translationKey: 'homemaker',
      ),
    ];
  }
}
