import 'package:flutter/material.dart';
import '../models/user_type_model.dart';

class OnboardingViewModel extends ChangeNotifier {
  UserType? _selectedUserType;
  bool _isLoading = false;

  UserType? get selectedUserType => _selectedUserType;
  bool get isLoading => _isLoading;
  bool get canContinue => _selectedUserType != null;

  List<UserTypeModel> get userTypes => UserTypeModel.getUserTypes();

  void selectUserType(UserType type) {
    _selectedUserType = type;
    notifyListeners();
  }

  Future<void> onContinuePressed(BuildContext context) async {
    if (!canContinue) return;

    _isLoading = true;
    notifyListeners();

    // Simulate API call or processing
    await Future.delayed(const Duration(milliseconds: 500));

    _isLoading = false;
    notifyListeners();

    if (context.mounted) {
      Navigator.pushNamed(context, '/details');
    }
  }
}
