import 'package:flutter/material.dart';

class CalculatorViewModel extends ChangeNotifier {
  final TextEditingController amountController =
      TextEditingController();
  final TextEditingController rateController =
      TextEditingController();
  final TextEditingController monthsController =
      TextEditingController();

  double? result;

  CalculatorViewModel() {
    // 🔑 Listen to text changes
    amountController.addListener(_onTextChanged);
    rateController.addListener(_onTextChanged);
    monthsController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    // Rebuild UI when input changes
    notifyListeners();
  }

  bool get canCalculate =>
      amountController.text.isNotEmpty &&
      rateController.text.isNotEmpty &&
      monthsController.text.isNotEmpty;

  void calculate() {
    final p = double.tryParse(amountController.text);
    final r = double.tryParse(rateController.text);
    final t = double.tryParse(monthsController.text);

    if (p == null || r == null || t == null) return;

    result = (p * r * t) / 100;
    notifyListeners();
  }

  void reset() {
    amountController.clear();
    rateController.clear();
    monthsController.clear();
    result = null;
    notifyListeners();
  }

  double get totalRepayment =>
      result == null
          ? 0
          : double.parse(amountController.text) + result!;

  @override
  void dispose() {
    amountController.dispose();
    rateController.dispose();
    monthsController.dispose();
    super.dispose();
  }
}
