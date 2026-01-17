import 'package:financio_app/models/userprofile_model.dart';
import 'package:financio_app/views/calculator_screen.dart';
import 'package:flutter/material.dart';
import '../models/education_model.dart';
import '../models/income_model.dart';

class HomeViewModel extends ChangeNotifier {
  final UserProfile userProfile;
  final List<Lesson> lessons;

  final EducationLevel? educationLevel;
  final IncomeRange? incomeRange;

  String _language = 'en';
  String get language => _language;

  bool _habitCompleted = false;
  bool get habitCompleted => _habitCompleted;

  String? _dailyHabitText;
  String? get dailyHabitText => _dailyHabitText;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  HomeViewModel({
    required this.userProfile,
    required this.lessons,
    this.educationLevel,
    this.incomeRange,
    String initialLanguage = 'en',
  }) {
    _language = initialLanguage;
  }

  void changeLanguage(String value) {
    _language = value;
    notifyListeners();
  }

  void startGame(BuildContext context) {
    // TODO: navigate to game screen
  }

void openTools(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => CalculatorScreen(
        language: _language,
        onLanguageChanged: changeLanguage,
      ),
    ),
  );
}

  void openLesson(BuildContext context, Lesson lesson) {
    // TODO: navigate to lesson details
  }

  void completeDailyHabit(BuildContext context) {
    _habitCompleted = true;
    notifyListeners();
    // TODO: implement habit completion logic
  }

  void startDailyQuiz(BuildContext context) {
    // TODO: navigate to quiz screen
  }
}
