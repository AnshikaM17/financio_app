import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/education_model.dart';
import '../models/income_model.dart';
import '../viewmodels/home_viewmodel.dart';
import '../views/home_screen.dart';
import '../models/userprofile_model.dart';

class DetailsViewModel extends ChangeNotifier {
  EducationLevel? _selectedEducation;
  IncomeRange? _selectedIncome;
  bool _isLoading = false;

  EducationLevel? get selectedEducation => _selectedEducation;
  IncomeRange? get selectedIncome => _selectedIncome;
  bool get isLoading => _isLoading;
  bool get canContinue =>
      _selectedEducation != null && _selectedIncome != null;

  List<EducationModel> get educationLevels =>
      EducationModel.getEducationLevels();

  List<IncomeModel> get incomeRanges =>
      IncomeModel.getIncomeRanges();

  void selectEducation(EducationLevel level) {
    _selectedEducation = level;
    notifyListeners();
  }

  void selectIncome(IncomeRange range) {
    _selectedIncome = range;
    notifyListeners();
  }

  Future<void> onStartLearningPressed(BuildContext context) async {
    if (!canContinue) return;

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _isLoading = false;
    notifyListeners();

    if (!context.mounted) return;

    /// TEMP data (replace later with API)
    final userProfile = UserProfile(
      totalXP: 0,
      streak: 0,
    );

    final lessons = <Lesson>[
      Lesson(
        id: '1',
        titleEn: 'Basics of Saving',
        titleHi: 'बचत की मूल बातें',
      ),
      Lesson(
        id: '2',
        titleEn: 'Understanding Interest',
        titleHi: 'ब्याज को समझना',
      ),
    ];

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider(
          create: (_) => HomeViewModel(
            userProfile: userProfile,
            lessons: lessons,
            educationLevel: _selectedEducation,
            incomeRange: _selectedIncome,
          ),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}
