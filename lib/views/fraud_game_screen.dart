import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class FraudGameScreen extends StatefulWidget {
  final String language;
  final Function(String) onLanguageChanged;

  const FraudGameScreen({
    super.key,
    required this.language,
    required this.onLanguageChanged,
  });

  @override
  State<FraudGameScreen> createState() => _FraudGameScreenState();
}

class _FraudGameScreenState extends State<FraudGameScreen> {
  final FlutterTts _flutterTts = FlutterTts();
  int _currentScenario = 0;
  int _score = 0;
  int _lives = 3;
  bool _showResult = false;
  bool _isCorrect = false;
  bool _gameCompleted = false;

  final List<FraudScenario> _scenarios = [
    FraudScenario(
      id: 1,
      titleEn: 'Unknown Caller Offers Prize',
      titleHi: 'अनजान कॉलर पुरस्कार देने की बात करता है',
      descriptionEn:
          'You receive a call: "Congratulations! You won ₹10 lakh lottery! To claim, share your bank details and pay ₹5,000 processing fee."',
      descriptionHi:
          'आपको कॉल आती है: "बधाई हो! आपने ₹10 लाख की लॉटरी जीती है! क्लेम करने के लिए अपने बैंक विवरण शेयर करें और ₹5,000 प्रोसेसिंग फीस दें।"',
      optionAEn: 'Share details immediately',
      optionAHi: 'तुरंत विवरण शेयर करें',
      optionBEn: 'Hang up and report',
      optionBHi: 'फोन काटें और रिपोर्ट करें',
      correctAnswer: 'B',
      explanationEn:
          'This is a classic lottery scam! Real lotteries never ask for fees upfront. Never share bank details with unknown callers.',
      explanationHi:
          'यह एक क्लासिक लॉटरी स्कैम है! असली लॉटरी कभी भी पहले से फीस नहीं मांगती। अनजान कॉलर्स को कभी बैंक विवरण न दें।',
      icon: Icons.phone_in_talk,
      color: Color(0xFFEF4444),
    ),
    FraudScenario(
      id: 2,
      titleEn: 'Urgent Bank Message',
      titleHi: 'जरूरी बैंक संदेश',
      descriptionEn:
          'SMS: "Your bank account will be blocked in 2 hours! Click this link immediately and enter your ATM PIN to verify."',
      descriptionHi:
          'SMS: "आपका बैंक खाता 2 घंटे में ब्लॉक हो जाएगा! तुरंत इस लिंक पर क्लिक करें और अपना ATM PIN डालकर वेरिफाई करें।"',
      optionAEn: 'Click link and verify',
      optionAHi: 'लिंक पर क्लिक करें और वेरिफाई करें',
      optionBEn: 'Call bank\'s official number',
      optionBHi: 'बैंक के आधिकारिक नंबर पर कॉल करें',
      correctAnswer: 'B',
      explanationEn:
          'Phishing scam! Banks never ask for PIN via SMS or link. Always contact your bank directly using official numbers.',
      explanationHi:
          'फिशिंग स्कैम! बैंक कभी भी SMS या लिंक से PIN नहीं मांगते। हमेशा आधिकारिक नंबर से बैंक से संपर्क करें।',
      icon: Icons.sms,
      color: Color(0xFFF59E0B),
    ),
    FraudScenario(
      id: 3,
      titleEn: 'OTP Request',
      titleHi: 'OTP मांगना',
      descriptionEn:
          'A person calls claiming to be from your bank: "Sir, we need to verify your account. Please tell me the OTP you just received."',
      descriptionHi:
          'एक व्यक्ति आपके बैंक से होने का दावा करते हुए कॉल करता है: "सर, हमें आपका खाता वेरिफाई करना है। कृपया आपको अभी जो OTP मिला है वो बताएं।"',
      optionAEn: 'Share the OTP',
      optionAHi: 'OTP शेयर करें',
      optionBEn: 'Never share OTP',
      optionBHi: 'OTP कभी शेयर न करें',
      correctAnswer: 'B',
      explanationEn:
          'Never share OTP with anyone! Banks never ask for OTP. OTP is only for your use to authorize transactions.',
      explanationHi:
          'OTP किसी से शेयर न करें! बैंक कभी OTP नहीं मांगते। OTP केवल आपके लिए है लेनदेन को अधिकृत करने के लिए।',
      icon: Icons.password,
      color: Color(0xFFDC2626),
    ),
    FraudScenario(
      id: 4,
      titleEn: 'Investment Opportunity',
      titleHi: 'निवेश का अवसर',
      descriptionEn:
          'WhatsApp message: "Guaranteed 300% returns in 30 days! Invest in our company now. Limited slots! Pay ₹20,000 today."',
      descriptionHi:
          'WhatsApp संदेश: "30 दिनों में 300% रिटर्न गारंटीड! अभी हमारी कंपनी में निवेश करें। सीमित स्लॉट! आज ₹20,000 दें।"',
      optionAEn: 'Invest immediately',
      optionAHi: 'तुरंत निवेश करें',
      optionBEn: 'Ignore - it\'s too good to be true',
      optionBHi: 'अनदेखा करें - यह सच होने के लिए बहुत अच्छा है',
      correctAnswer: 'B',
      explanationEn:
          'Investment scam! No legitimate investment guarantees such high returns. Always verify company credentials before investing.',
      explanationHi:
          'निवेश स्कैम! कोई भी वैध निवेश इतना ज्यादा रिटर्न गारंटी नहीं देता। निवेश से पहले हमेशा कंपनी की साख जांचें।',
      icon: Icons.trending_up,
      color: Color(0xFF8B5CF6),
    ),
    FraudScenario(
      id: 5,
      titleEn: 'KYC Update Required',
      titleHi: 'KYC अपडेट जरूरी',
      descriptionEn:
          'Email: "Your KYC is expired! Update now by clicking this link and uploading Aadhaar photos and bank passbook."',
      descriptionHi:
          'ईमेल: "आपका KYC एक्सपायर हो गया है! इस लिंक पर क्लिक कर आधार फोटो और बैंक पासबुक अपलोड करके अभी अपडेट करें।"',
      optionAEn: 'Upload documents on link',
      optionAHi: 'लिंक पर दस्तावेज़ अपलोड करें',
      optionBEn: 'Visit bank branch for KYC',
      optionBHi: 'KYC के लिए बैंक शाखा जाएं',
      correctAnswer: 'B',
      explanationEn:
          'Identity theft scam! Never upload sensitive documents via email links. Always complete KYC at official bank branches.',
      explanationHi:
          'पहचान चोरी स्कैम! ईमेल लिंक से कभी भी संवेदनशील दस्तावेज़ अपलोड न करें। हमेशा आधिकारिक बैंक शाखा में KYC पूरा करें।',
      icon: Icons.credit_card,
      color: Color(0xFF06B6D4),
    ),
    FraudScenario(
      id: 6,
      titleEn: 'Social Media Loan Offer',
      titleHi: 'सोशल मीडिया लोन ऑफर',
      descriptionEn:
          'Facebook ad: "Instant loan without documents! ₹5 lakh in 1 hour. Just pay ₹3,000 advance fee. No questions asked!"',
      descriptionHi:
          'Facebook विज्ञापन: "बिना दस्तावेज़ तुरंत लोन! 1 घंटे में ₹5 लाख। बस ₹3,000 एडवांस फीस दें। कोई सवाल नहीं!"',
      optionAEn: 'Pay advance fee',
      optionAHi: 'एडवांस फीस दें',
      optionBEn: 'Apply through registered lender',
      optionBHi: 'पंजीकृत लोनदाता के माध्यम से आवेदन करें',
      correctAnswer: 'B',
      explanationEn:
          'Loan scam! Legitimate lenders never ask for advance fees. Always use banks or RBI-registered NBFCs for loans.',
      explanationHi:
          'लोन स्कैम! वैध लोनदाता कभी एडवांस फीस नहीं मांगते। हमेशा बैंक या RBI-पंजीकृत NBFC से लोन लें।',
      icon: Icons.account_balance_wallet,
      color: Color(0xFF10B981),
    ),
    FraudScenario(
      id: 7,
      titleEn: 'Fake Delivery Message',
      titleHi: 'नकली डिलीवरी संदेश',
      descriptionEn:
          'SMS: "Your parcel is stuck at customs. Pay ₹500 now to release it. Click: bit.ly/xyz123. Hurry, only 24 hours!"',
      descriptionHi:
          'SMS: "आपका पार्सल कस्टम में अटका है। इसे रिलीज़ करने के लिए अभी ₹500 दें। क्लिक करें: bit.ly/xyz123. जल्दी करें, सिर्फ 24 घंटे!"',
      optionAEn: 'Click link and pay',
      optionAHi: 'लिंक पर क्लिक करें और भुगतान करें',
      optionBEn: 'Verify with official courier',
      optionBHi: 'आधिकारिक कूरियर से जांच करें',
      correctAnswer: 'B',
      explanationEn:
          'Delivery scam! Always verify such messages with official courier services. Don\'t click suspicious short links.',
      explanationHi:
          'डिलीवरी स्कैम! ऐसे संदेशों को हमेशा आधिकारिक कूरियर सेवा से जांचें। संदिग्ध छोटे लिंक पर क्लिक न करें।',
      icon: Icons.local_shipping,
      color: Color(0xFFF97316),
    ),
    FraudScenario(
      id: 8,
      titleEn: 'Job Offer Scam',
      titleHi: 'नौकरी ऑफर स्कैम',
      descriptionEn:
          'Email: "You\'re selected for a high-paying job! Send ₹10,000 for training and registration. Start earning ₹50,000/month!"',
      descriptionHi:
          'ईमेल: "आप एक उच्च वेतन वाली नौकरी के लिए चुने गए हैं! प्रशिक्षण और पंजीकरण के लिए ₹10,000 भेजें। ₹50,000/महीना कमाना शुरू करें!"',
      optionAEn: 'Pay for the job',
      optionAHi: 'नौकरी के लिए भुगतान करें',
      optionBEn: 'Real jobs don\'t ask for money',
      optionBHi: 'असली नौकरियां पैसे नहीं मांगतीं',
      correctAnswer: 'B',
      explanationEn:
          'Job scam! Legitimate employers never charge fees for jobs. Be cautious of too-good-to-be-true offers.',
      explanationHi:
          'नौकरी स्कैम! वैध नियोक्ता नौकरी के लिए कभी फीस नहीं लेते। सच होने के लिए बहुत अच्छे ऑफर से सावधान रहें।',
      icon: Icons.work,
      color: Color(0xFF3B82F6),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  void _initTts() async {
    await _flutterTts.setLanguage(widget.language == 'hi' ? 'hi-IN' : 'en-US');
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> _speak(String text) async {
    await _flutterTts.setLanguage(widget.language == 'hi' ? 'hi-IN' : 'en-US');
    await _flutterTts.speak(text);
  }

  @override
  void dispose() {
    _flutterTts.stop();
    super.dispose();
  }

  void _checkAnswer(String answer) {
    setState(() {
      _showResult = true;
      _isCorrect = answer == _scenarios[_currentScenario].correctAnswer;

      if (_isCorrect) {
        _score += 10;
        _speak(widget.language == 'hi' ? 'सही उत्तर!' : 'Correct answer!');
      } else {
        _lives--;
        _speak(widget.language == 'hi' ? 'गलत उत्तर' : 'Wrong answer');
      }
    });
  }

  void _nextScenario() {
    if (_lives <= 0) {
      setState(() {
        _gameCompleted = true;
      });
      return;
    }

    if (_currentScenario < _scenarios.length - 1) {
      setState(() {
        _currentScenario++;
        _showResult = false;
      });
    } else {
      setState(() {
        _gameCompleted = true;
      });
    }
  }

  void _restartGame() {
    setState(() {
      _currentScenario = 0;
      _score = 0;
      _lives = 3;
      _showResult = false;
      _gameCompleted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_gameCompleted) {
      return _buildGameOver();
    }

    final scenario = _scenarios[_currentScenario];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.language == 'hi' ? 'धोखाधड़ी पहचानो' : 'Spot the Scam',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up),
            onPressed: () {
              _speak(widget.language == 'hi'
                  ? scenario.descriptionHi
                  : scenario.descriptionEn);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress and Stats
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.blue.shade50, Colors.blue.shade100],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.stars, color: Color(0xFF3B82F6)),
                          const SizedBox(width: 8),
                          Text(
                            widget.language == 'hi'
                                ? 'स्कोर: $_score'
                                : 'Score: $_score',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.red.shade50, Colors.red.shade100],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        ...List.generate(
                          3,
                          (index) => Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Icon(
                              index < _lives
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Progress bar
              Row(
                children: [
                  Text(
                    '${_currentScenario + 1}/${_scenarios.length}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: (_currentScenario + 1) / _scenarios.length,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation(scenario.color),
                        minHeight: 8,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Scenario Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      scenario.color.withOpacity(0.1),
                      scenario.color.withOpacity(0.05),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: scenario.color.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: scenario.color.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        scenario.icon,
                        size: 48,
                        color: scenario.color,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      widget.language == 'hi'
                          ? scenario.titleHi
                          : scenario.titleEn,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: scenario.color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.language == 'hi'
                            ? scenario.descriptionHi
                            : scenario.descriptionEn,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              if (!_showResult) ...[
                // Question
                Text(
                  widget.language == 'hi'
                      ? 'आप क्या करेंगे?'
                      : 'What would you do?',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Options
                _buildOptionButton(
                  'A',
                  widget.language == 'hi'
                      ? scenario.optionAHi
                      : scenario.optionAEn,
                  Colors.blue,
                ),
                const SizedBox(height: 12),
                _buildOptionButton(
                  'B',
                  widget.language == 'hi'
                      ? scenario.optionBHi
                      : scenario.optionBEn,
                  Colors.green,
                ),
              ],

              if (_showResult) ...[
                // Result
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: _isCorrect
                        ? Colors.green.shade50
                        : Colors.red.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _isCorrect
                          ? Colors.green.shade300
                          : Colors.red.shade300,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        _isCorrect ? Icons.check_circle : Icons.cancel,
                        size: 64,
                        color: _isCorrect ? Colors.green : Colors.red,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        _isCorrect
                            ? (widget.language == 'hi'
                                ? '🎉 बहुत बढ़िया!'
                                : '🎉 Great Job!')
                            : (widget.language == 'hi'
                                ? '❌ गलत उत्तर'
                                : '❌ Wrong Answer'),
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: _isCorrect ? Colors.green : Colors.red,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Icons.lightbulb,
                                    color: Color(0xFFF59E0B)),
                                const SizedBox(width: 8),
                                Text(
                                  widget.language == 'hi'
                                      ? 'याद रखें:'
                                      : 'Remember:',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              widget.language == 'hi'
                                  ? scenario.explanationHi
                                  : scenario.explanationEn,
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: _nextScenario,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: scenario.color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.language == 'hi'
                                    ? 'अगला'
                                    : 'Next',
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
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(String option, String text, Color color) {
    return InkWell(
      onTap: () => _checkAnswer(option),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  option,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameOver() {
    final percentage = (_score / (_scenarios.length * 10) * 100).round();
    final isPassed = percentage >= 60;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.language == 'hi' ? 'परिणाम' : 'Results',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isPassed
                        ? [Colors.green.shade50, Colors.green.shade100]
                        : [Colors.orange.shade50, Colors.orange.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: isPassed
                        ? Colors.green.shade300
                        : Colors.orange.shade300,
                    width: 3,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      isPassed ? Icons.emoji_events : Icons.school,
                      size: 80,
                      color: isPassed ? Colors.green : Colors.orange,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      isPassed
                          ? (widget.language == 'hi'
                              ? '🎉 बधाई हो!'
                              : '🎉 Congratulations!')
                          : (widget.language == 'hi'
                              ? '📚 अच्छी कोशिश!'
                              : '📚 Good Effort!'),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatCard(
                          widget.language == 'hi' ? 'स्कोर' : 'Score',
                          '$_score/${_scenarios.length * 10}',
                          Icons.stars,
                          Colors.blue,
                        ),
                        _buildStatCard(
                          widget.language == 'hi' ? 'सटीकता' : 'Accuracy',
                          '$percentage%',
                          Icons.percent,
                          Colors.purple,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        isPassed
                            ? (widget.language == 'hi'
                                ? 'आप धोखाधड़ी को पहचानने में माहिर हैं! अपने ज्ञान को दूसरों के साथ साझा करें।'
                                : 'You\'re a fraud detection expert! Share your knowledge with others.')
                            : (widget.language == 'hi'
                                ? 'अधिक सीखने के लिए गेम फिर से खेलें और सतर्क रहें!'
                                : 'Play again to learn more and stay vigilant!'),
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: _restartGame,
                  icon: const Icon(Icons.replay),
                  label: Text(
                    widget.language == 'hi' ? 'फिर से खेलें' : 'Play Again',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF22C55E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.home),
                  label: Text(
                    widget.language == 'hi'
                        ? 'होम पर वापस जाएं'
                        : 'Back to Home',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF22C55E),
                    side: const BorderSide(
                      color: Color(0xFF22C55E),
                      width: 2,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class FraudScenario {
  final int id;
  final String titleEn;
  final String titleHi;
  final String descriptionEn;
  final String descriptionHi;
  final String optionAEn;
  final String optionAHi;
  final String optionBEn;
  final String optionBHi;
  final String correctAnswer;
  final String explanationEn;
  final String explanationHi;
  final IconData icon;
  final Color color;

  FraudScenario({
    required this.id,
    required this.titleEn,
    required this.titleHi,
    required this.descriptionEn,
    required this.descriptionHi,
    required this.optionAEn,
    required this.optionAHi,
    required this.optionBEn,
    required this.optionBHi,
    required this.correctAnswer,
    required this.explanationEn,
    required this.explanationHi,
    required this.icon,
    required this.color,
  });
}
