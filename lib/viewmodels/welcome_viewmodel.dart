import 'package:flutter/material.dart';
import '../models/language_model.dart';

class WelcomeViewModel extends ChangeNotifier {
  Locale _currentLocale = const Locale('hi');
  bool _isLoading = false;

  Locale get currentLocale => _currentLocale;
  bool get isLoading => _isLoading;

  List<LanguageModel> get supportedLanguages =>
      LanguageModel.getSupportedLanguages();

  void changeLanguage(String languageCode) {
    _currentLocale = Locale(languageCode);
    notifyListeners();
  }

  Future<void> onStartPressed(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    // Simulate loading
    await Future.delayed(const Duration(milliseconds: 500));

    _isLoading = false;
    notifyListeners();

    if (context.mounted) {
      Navigator.pushNamed(context, '/onboarding');
    }
  }
}
