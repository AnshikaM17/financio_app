import 'package:financio_app/utils/widgets/feature_button.dart';
import 'package:financio_app/utils/widgets/language_dropdown.dart';
import 'package:financio_app/utils/widgets/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Header(vm),
                  const SizedBox(height: 28),

                  /// 🔧 TOOLS & GAMES
                  _SectionTitle(
                    titleHi: 'सुविधाएं और खेल',
                    titleEn: 'Tools & Games',
                    language: vm.language,
                  ),
                  const SizedBox(height: 14),

                  Row(
                    children: [
                      Expanded(
                        child: FeatureButton(
                          title: vm.language == 'hi'
                              ? 'पढ़ना शुरू करें'
                              : 'Start Lessons',
                          subtitle: 'Fraud & Needs',
                          icon: Icons.school,
                          gradient: const [
                            Color(0xFF3B82F6),
                            Color(0xFF2563EB),
                          ],
                          onTap: () {
                            if (!vm.isLoading) {
                              vm.startGame(context);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FeatureButton(
                          title: vm.language == 'hi'
                              ? 'कैलकुलेटर'
                              : 'Calculator',
                          subtitle: 'Interest Rate',
                          icon: Icons.calculate,
                          gradient: const [
                            Color(0xFFA855F7),
                            Color(0xFF7E22CE),
                          ],
                          onTap: () {
                            if (!vm.isLoading) {
                              vm.openTools(context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),

                  /// 🧠 TODAY WITH MITRA
                  _SectionTitle(
                    titleHi: 'आज मित्रा के साथ',
                    titleEn: 'Today with Mitra',
                    language: vm.language,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: FeatureButton(
                          title: vm.language == 'hi'
                              ? 'आज की आदत'
                              : 'Daily Habit',
                          subtitle: vm.habitCompleted
                              ? (vm.language == 'hi'
                                    ? 'आज पूरी हो गई ✅'
                                    : 'Completed today ✅')
                              : (vm.dailyHabitText ??
                                    (vm.language == 'hi'
                                        ? 'छोटी वित्तीय आदत'
                                        : 'Small financial habit')),
                          icon: vm.habitCompleted
                              ? Icons.check_circle
                              : Icons.self_improvement,
                          gradient: vm.habitCompleted
                              ? const [Color(0xFF9CA3AF), Color(0xFF6B7280)]
                              : const [Color(0xFF22C55E), Color(0xFF16A34A)],
                          onTap: () {
                            if (!vm.isLoading) {
                              vm.openDailyHabit(context);
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FeatureButton(
                          title: vm.language == 'hi'
                              ? 'आज का प्रश्न'
                              : 'Today’s Question',
                          subtitle: vm.language == 'hi'
                              ? '1 मिनट क्विज़'
                              : '1-minute quiz',
                          icon: Icons.quiz,
                          gradient: const [
                            Color(0xFF6366F1),
                            Color(0xFF4F46E5),
                          ],
                          onTap: () {
                            if (!vm.isLoading) {
                              vm.startDailyQuiz(context);
                            }
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 28),

                  /// ℹ️ ABOUT MITRA
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF22C55E).withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.auto_awesome,
                            color: Color(0xFF16A34A),
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vm.language == 'hi'
                                    ? 'मित्रा के बारे में'
                                    : 'About Mitra',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                vm.language == 'hi'
                                    ? 'मित्रा आपका एआई वित्तीय साथी है, जो रोज़ाना सवालों, आदतों और स्मार्ट मार्गदर्शन से बेहतर पैसे की समझ बनाता है।'
                                    : 'Mitra is your AI-powered financial companion, helping you build better money habits through daily questions and smart guidance.',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                  height: 1.4,
                                ),
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
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String titleHi;
  final String titleEn;
  final String language;

  const _SectionTitle({
    required this.titleHi,
    required this.titleEn,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      language == 'hi' ? titleHi : titleEn,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class _Header extends StatelessWidget {
  final HomeViewModel vm;
  const _Header(this.vm);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      vm.language == 'hi' ? 'नमस्ते! 👋' : 'Hello! 👋',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      vm.language == 'hi'
                          ? 'आज क्या सीखना चाहेंगे?'
                          : 'What would you like to learn?',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              LanguageDropdown(
                value: vm.language,
                onChanged: vm.changeLanguage,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              StatCard(label: 'XP', value: vm.userProfile.totalXP.toString()),
              const SizedBox(width: 12),
              StatCard(
                label: vm.language == 'hi' ? 'स्ट्रीक' : 'Streak',
                value: '${vm.userProfile.streak} 🔥',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
