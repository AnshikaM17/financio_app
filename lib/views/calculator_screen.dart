import 'package:financio_app/utils/widgets/language_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/calculator_viewmodel.dart';

class CalculatorScreen extends StatelessWidget {
  final String language;
  final ValueChanged<String> onLanguageChanged;

  const CalculatorScreen({
    super.key,
    required this.language,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CalculatorViewModel(),
      child: _CalculatorContent(
        language: language,
        onLanguageChanged: onLanguageChanged,
      ),
    );
  }
}

class _CalculatorContent extends StatelessWidget {
  final String language;
  final ValueChanged<String> onLanguageChanged;

  const _CalculatorContent({
    required this.language,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CalculatorViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              /// 🔝 Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    language == 'hi'
                        ? 'ब्याज कैलकुलेटर'
                        : 'Interest Calculator',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  LanguageDropdown(
                    value: language,
                    onChanged: onLanguageChanged,
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// 📦 Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 20,
                      color: Colors.black12,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _input(
                      label: language == 'hi'
                          ? 'मूल राशि (₹)'
                          : 'Principal Amount (₹)',
                      hint: '10000',
                      controller: vm.amountController,
                    ),
                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: _input(
                            label: language == 'hi'
                                ? 'दर (% प्रति माह)'
                                : 'Rate (% per month)',
                            hint: '2',
                            controller: vm.rateController,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _input(
                            label: language == 'hi'
                                ? 'समय (महीने)'
                                : 'Time (Months)',
                            hint: '6',
                            controller: vm.monthsController,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: vm.canCalculate ? vm.calculate : null,
                        child: Text(
                          language == 'hi'
                              ? 'गिनाई करें (Calculate)'
                              : 'Calculate Interest',
                        ),
                      ),
                    ),

                    if (vm.result != null) ...[
                      const SizedBox(height: 32),
                      Text(
                        '₹${vm.result!.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: vm.reset,
                        icon: const Icon(Icons.refresh, size: 16),
                        label: const Text('Reset'),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _input({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: const Color(0xFFF3F4F6),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
