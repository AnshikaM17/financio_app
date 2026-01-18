import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import '../viewmodels/schemes_viewmodel.dart';
import '../models/government_scheme_model.dart';
import 'scheme_detail_screen.dart';

class SchemesScreen extends StatefulWidget {
  const SchemesScreen({super.key});

  @override
  State<SchemesScreen> createState() => _SchemesScreenState();
}

class _SchemesScreenState extends State<SchemesScreen> {
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  void _initTts() async {
    await _flutterTts.setLanguage("hi-IN");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> _speak(String text, String language) async {
    await _flutterTts.setLanguage(language == 'hi' ? 'hi-IN' : 'en-US');
    await _flutterTts.speak(text);
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SchemesViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              vm.language == 'hi' ? 'सरकारी योजनाएं' : 'Government Schemes',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            foregroundColor: Colors.black,
          ),
          body: vm.questionnaireCompleted
              ? _buildSchemesList(vm)
              : _buildQuestionnaire(vm),
        );
      },
    );
  }

  Widget _buildQuestionnaire(SchemesViewModel vm) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.assignment, color: Colors.white, size: 32),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        vm.language == 'hi'
                            ? 'योग्यता प्रश्नावली'
                            : 'Eligibility Questionnaire',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.volume_up, color: Colors.white),
                      onPressed: () {
                        _speak(
                          vm.language == 'hi'
                              ? 'योग्यता प्रश्नावली'
                              : 'Eligibility Questionnaire',
                          vm.language,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  vm.language == 'hi'
                      ? 'कृपया अपने लिए उपयुक्त योजनाओं को खोजने के लिए निम्नलिखित प्रश्नों का उत्तर दें'
                      : 'Please answer the following questions to find suitable schemes for you',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Info Banner
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue.shade700),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    vm.language == 'hi'
                        ? '📅 योजनाएं नियमित रूप से अपडेट होती हैं (अभी तक की योजनाएं)'
                        : '📅 Schemes updated regularly (schemes as of now)',
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Questions
          _buildQuestion(
            vm,
            'occupation',
            vm.language == 'hi' ? 'आपका व्यवसाय क्या है?' : 'What is your occupation?',
            [
              {'value': 'farmer', 'label': vm.language == 'hi' ? 'किसान' : 'Farmer'},
              {'value': 'business', 'label': vm.language == 'hi' ? 'व्यवसाय' : 'Business'},
              {'value': 'employed', 'label': vm.language == 'hi' ? 'नौकरी' : 'Employed'},
              {'value': 'student', 'label': vm.language == 'hi' ? 'विद्यार्थी' : 'Student'},
              {'value': 'other', 'label': vm.language == 'hi' ? 'अन्य' : 'Other'},
            ],
          ),

          const SizedBox(height: 20),

          _buildBooleanQuestion(
            vm,
            'landOwner',
            vm.language == 'hi' ? 'क्या आपके पास कृषि भूमि है?' : 'Do you own agricultural land?',
          ),

          const SizedBox(height: 20),

          _buildQuestion(
            vm,
            'income',
            vm.language == 'hi'
                ? 'आपकी वार्षिक आय क्या है?'
                : 'What is your annual income?',
            [
              {
                'value': 'low',
                'label': vm.language == 'hi' ? '₹3 लाख से कम' : 'Below ₹3 Lakh'
              },
              {
                'value': 'medium',
                'label': vm.language == 'hi' ? '₹3-10 लाख' : '₹3-10 Lakh'
              },
              {
                'value': 'high',
                'label': vm.language == 'hi' ? '₹10 लाख से अधिक' : 'Above ₹10 Lakh'
              },
            ],
          ),

          const SizedBox(height: 20),

          _buildBooleanQuestion(
            vm,
            'hasBankAccount',
            vm.language == 'hi' ? 'क्या आपका बैंक खाता है?' : 'Do you have a bank account?',
          ),

          const SizedBox(height: 20),

          _buildBooleanQuestion(
            vm,
            'hasAadhar',
            vm.language == 'hi' ? 'क्या आपके पास आधार कार्ड है?' : 'Do you have Aadhaar card?',
          ),

          const SizedBox(height: 32),

          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: vm.answers.length >= 3
                  ? () {
                      vm.submitQuestionnaire();
                      _speak(
                        vm.language == 'hi'
                            ? 'आपके लिए उपयुक्त योजनाएं खोजी जा रही हैं'
                            : 'Finding suitable schemes for you',
                        vm.language,
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16A34A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    vm.language == 'hi' ? 'योजनाएं खोजें' : 'Find Schemes',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildQuestion(
    SchemesViewModel vm,
    String id,
    String question,
    List<Map<String, String>> options,
  ) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up, size: 20),
                  onPressed: () => _speak(question, vm.language),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...options.map((option) {
              final isSelected = vm.answers[id] == option['value'];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: InkWell(
                  onTap: () => vm.setAnswer(id, option['value']),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF22C55E).withOpacity(0.1)
                          : Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isSelected
                            ? const Color(0xFF16A34A)
                            : Colors.grey.shade300,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.radio_button_checked
                              : Icons.radio_button_unchecked,
                          color: isSelected
                              ? const Color(0xFF16A34A)
                              : Colors.grey,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            option['label']!,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight:
                                  isSelected ? FontWeight.w600 : FontWeight.normal,
                              color: isSelected ? Colors.black : Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBooleanQuestion(SchemesViewModel vm, String id, String question) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.volume_up, size: 20),
                  onPressed: () => _speak(question, vm.language),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildBooleanOption(
                    vm,
                    id,
                    true,
                    vm.language == 'hi' ? 'हाँ' : 'Yes',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildBooleanOption(
                    vm,
                    id,
                    false,
                    vm.language == 'hi' ? 'नहीं' : 'No',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBooleanOption(
    SchemesViewModel vm,
    String id,
    bool value,
    String label,
  ) {
    final isSelected = vm.answers[id] == value;
    return InkWell(
      onTap: () => vm.setAnswer(id, value),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF22C55E).withOpacity(0.1)
              : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected ? const Color(0xFF16A34A) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              color: isSelected ? Colors.black : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSchemesList(SchemesViewModel vm) {
    return Column(
      children: [
        // Header with reset button
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade200),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vm.language == 'hi'
                              ? 'आपके लिए योजनाएं'
                              : 'Schemes For You',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          vm.language == 'hi'
                              ? '${vm.eligibleSchemes.length} योजनाएं मिलीं'
                              : '${vm.eligibleSchemes.length} schemes found',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => vm.resetQuestionnaire(),
                    icon: const Icon(Icons.refresh, size: 18),
                    label: Text(vm.language == 'hi' ? 'फिर से' : 'Retake'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.green.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 18, color: Colors.green.shade700),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        vm.language == 'hi'
                            ? 'योजनाएं आपकी प्रोफ़ाइल के आधार पर व्यक्तिगत हैं'
                            : 'Schemes personalized based on your profile',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.green.shade900,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Schemes Grid
        Expanded(
          child: vm.eligibleSchemes.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.search_off,
                          size: 64, color: Colors.grey.shade400),
                      const SizedBox(height: 16),
                      Text(
                        vm.language == 'hi'
                            ? 'कोई योजना नहीं मिली'
                            : 'No schemes found',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: vm.eligibleSchemes.length,
                  itemBuilder: (context, index) {
                    final scheme = vm.eligibleSchemes[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _buildSchemeCard(vm, scheme),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildSchemeCard(SchemesViewModel vm, GovernmentScheme scheme) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SchemeDetailScreen(
              scheme: scheme,
              language: vm.language,
              onSpeak: _speak,
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.green.shade200, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.green.shade50,
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top section with icon and badge
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.green.shade50, Colors.green.shade100],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade200,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.account_balance,
                      color: Colors.green.shade700,
                      size: 32,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF16A34A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 14,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          vm.language == 'hi' ? 'पात्र' : 'Eligible',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Content section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    vm.language == 'hi' ? scheme.nameHi : scheme.nameEn,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 8),

                  // Description
                  Text(
                    vm.language == 'hi' ? scheme.shortDescHi : scheme.shortDescEn,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                      height: 1.5,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 16),

                  // View Details Button
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          vm.language == 'hi' ? 'विवरण देखें' : 'View Details',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.green.shade700,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.arrow_forward,
                          size: 16,
                          color: Colors.green.shade700,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
