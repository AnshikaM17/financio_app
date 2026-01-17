import 'package:financio_app/models/quiz_model.dart';
import 'package:financio_app/models/userprofile_model.dart';
import 'package:financio_app/views/calculator_screen.dart';
import 'package:financio_app/views/daily_habit_screen.dart';
import 'package:financio_app/views/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/education_model.dart';
import '../models/income_model.dart';
import '../core/api_service.dart';
import '../core/user_session.dart';

class HomeViewModel extends ChangeNotifier {
  final UserProfile userProfile;
  final List<Lesson> lessons;

  final EducationLevel? educationLevel;
  final IncomeRange? incomeRange;

  String _language = 'en';
  String get language => _language;

  String? _habitId;
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

  Future<void> loadDailyHabit() async {
    _isLoading = true;
    notifyListeners();

    final userId = await UserSession.getOrCreateUserId();

    final res = await ApiService.getDailyHabit(
      userId: userId,
      language: _language,
      profession: 'farmer', // later from profile
    );

    _dailyHabitText = res['habit'];
    _habitId = res['habit_id'];
    _habitCompleted = res['completed'];

    _isLoading = false;
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

  Future<void> completeDailyHabit(BuildContext context) async {
    if (_habitId == null) return;

    _isLoading = true;
    notifyListeners();

    final userId = await UserSession.getOrCreateUserId();

    await ApiService.completeHabit(userId: userId, habitId: _habitId!);

    _habitCompleted = true;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> openDailyHabit(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    await loadDailyHabit();

    _isLoading = false;
    notifyListeners();

    final homeVm = this; // 👈 IMPORTANT

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return ChangeNotifierProvider.value(
          value: homeVm,
          child: const DailyHabitSheet(),
        );
      },
    );
  }

  Future<void> startDailyQuiz(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final userId = await UserSession.getOrCreateUserId();

    final res = await ApiService.generateQuiz(
      userId: userId,
      language: _language,
      profession: 'farmer',
    );

    _isLoading = false;
    notifyListeners();

    final quiz = Quiz.fromJson(res);

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => QuizScreen(quiz: quiz)),
    );
  }

  void applyQuizResult({required int xpGained, required int streak}) {
    userProfile.totalXP += xpGained;
    userProfile.streak = streak;

    saveProfile();

    notifyListeners();
  }

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('xp', userProfile.totalXP);
    prefs.setInt('streak', userProfile.streak);
  }
}
