class LanguageModel {
  final String code;
  final String name;
  final String displayCode;

  LanguageModel({
    required this.code,
    required this.name,
    required this.displayCode,
  });

  static List<LanguageModel> getSupportedLanguages() {
    return [
      LanguageModel(code: 'hi', name: 'हिंदी', displayCode: 'HI'),
      LanguageModel(code: 'en', name: 'English', displayCode: 'EN'),
      LanguageModel(code: 'te', name: 'తెలుగు', displayCode: 'TE'),
      LanguageModel(code: 'ta', name: 'தமிழ்', displayCode: 'TA'),
      LanguageModel(code: 'bn', name: 'বাংলা', displayCode: 'BN'),
      LanguageModel(code: 'mr', name: 'मराठी', displayCode: 'MR'),
      LanguageModel(code: 'gu', name: 'ગુજરાતી', displayCode: 'GU'),
      LanguageModel(code: 'kn', name: 'ಕನ್ನಡ', displayCode: 'KN'),
    ];
  }
}
