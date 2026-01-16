import 'package:flutter/material.dart';
import '../models/education_model.dart';
import '../models/income_model.dart';

class DetailsViewModel extends ChangeNotifier {
  EducationLevel? _selectedEducation;
  IncomeRange? _selectedIncome;
  bool _isLoading = false;

  EducationLevel? get selectedEducation => _selectedEducation;
  IncomeRange? get selectedIncome => _selectedIncome;
  bool get isLoading => _isLoading;
  bool get canContinue => _selectedEducation != null && _selectedIncome != null;

  List<EducationModel> get educationLevels => EducationModel.getEducationLevels();
  List<IncomeModel> get incomeRanges => IncomeModel.getIncomeRanges();

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

    // Simulate API call or processing
    await Future.delayed(const Duration(milliseconds: 500));

    _isLoading = false;
    notifyListeners();

    if (context.mounted) {
      // Navigate to main app or home screen
      // For now, show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Education: ${_selectedEducation.toString()}, Income: ${_selectedIncome.toString()}',
          ),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }
}
