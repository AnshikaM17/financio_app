enum EducationLevel {
  noFormal,
  primary,
  secondary,
}

class EducationModel {
  final EducationLevel level;
  final String translationKey;

  EducationModel({
    required this.level,
    required this.translationKey,
  });

  static List<EducationModel> getEducationLevels() {
    return [
      EducationModel(
        level: EducationLevel.noFormal,
        translationKey: 'no_formal',
      ),
      EducationModel(
        level: EducationLevel.primary,
        translationKey: 'primary',
      ),
      EducationModel(
        level: EducationLevel.secondary,
        translationKey: 'secondary',
      ),
    ];
  }
}
