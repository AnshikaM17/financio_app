import 'package:flutter/material.dart';
import '../models/government_scheme_model.dart';

class SchemesViewModel extends ChangeNotifier {
  String _language = 'en';
  String get language => _language;

  bool _questionnaireCompleted = false;
  bool get questionnaireCompleted => _questionnaireCompleted;

  Map<String, dynamic> _answers = {};
  Map<String, dynamic> get answers => _answers;

  List<GovernmentScheme> _eligibleSchemes = [];
  List<GovernmentScheme> get eligibleSchemes => _eligibleSchemes;

  void changeLanguage(String value) {
    _language = value;
    notifyListeners();
  }

  void setAnswer(String questionId, dynamic value) {
    _answers[questionId] = value;
    notifyListeners();
  }

  void submitQuestionnaire() {
    _questionnaireCompleted = true;
    _determineEligibleSchemes();
    notifyListeners();
  }

  void resetQuestionnaire() {
    _questionnaireCompleted = false;
    _answers = {};
    _eligibleSchemes = [];
    notifyListeners();
  }

  void _determineEligibleSchemes() {
    // Based on questionnaire answers, filter eligible schemes
    List<GovernmentScheme> eligible = [];

    // Check each scheme's eligibility
    for (var scheme in dummyGovernmentSchemes) {
      bool isEligible = _checkEligibility(scheme);
      if (isEligible) {
        eligible.add(scheme);
      }
    }

    _eligibleSchemes = eligible;
  }

  bool _checkEligibility(GovernmentScheme scheme) {
    // Simple eligibility logic based on answers
    
    // If user is a farmer
    if (_answers['occupation'] == 'farmer') {
      if (scheme.eligibilityCriteria.contains('farmer')) {
        return true;
      }
    }

    // If user owns land
    if (_answers['landOwner'] == true) {
      if (scheme.eligibilityCriteria.contains('landowner')) {
        return true;
      }
    }

    // If user is low income
    if (_answers['income'] == 'low') {
      if (scheme.eligibilityCriteria.contains('lowincome')) {
        return true;
      }
    }

    // Schemes with no specific criteria (available to all)
    if (scheme.eligibilityCriteria.isEmpty) {
      return true;
    }

    return false;
  }
}
