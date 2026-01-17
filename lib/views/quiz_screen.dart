import 'package:financio_app/viewmodels/home_viewmodel.dart';
import 'package:flutter/material.dart';
import '../models/quiz_model.dart';
import '../models/quiz_result_model.dart';
import '../views/quiz_result_screen.dart';
import '../core/api_service.dart';
import '../core/user_session.dart';

class QuizScreen extends StatefulWidget {
  final Quiz quiz;
  final HomeViewModel homeViewModel;
  const QuizScreen({
    super.key,
    required this.quiz,
    required this.homeViewModel,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // 🔒 LOGIC UNCHANGED
  final Map<String, int> selectedIndexes = {};
  final Map<String, String> answers = {};

  String indexToLetter(int index) {
    return String.fromCharCode(65 + index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      // 🔰 MATCH HOME HEADER
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 48, 20, 28),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Row(
              children: const [
                Icon(Icons.quiz, color: Colors.white, size: 26),
                SizedBox(width: 12),
                Text(
                  "Today’s Question",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // 🧠 QUIZ BODY
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                ...widget.quiz.questions.map((q) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 24),
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          q.question,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 14),

                        ...List.generate(q.options.length, (i) {
                          final isSelected = selectedIndexes[q.id] == i;

                          return InkWell(
                            borderRadius: BorderRadius.circular(14),
                            onTap: () {
                              setState(() {
                                selectedIndexes[q.id] = i;
                                answers[q.id] = indexToLetter(i);
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF22C55E)
                                      : Colors.grey.shade300,
                                  width: 2,
                                ),
                                color: isSelected
                                    ? const Color(0xFF22C55E).withOpacity(0.08)
                                    : Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? const Color(0xFF22C55E)
                                            : Colors.grey,
                                      ),
                                      color: isSelected
                                          ? const Color(0xFF22C55E)
                                          : Colors.transparent,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      q.options[i],
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                }),

                // ✅ SUBMIT BUTTON (MATCH HOME STYLE)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF16A34A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: submitQuiz,
                    child: const Text(
                      "Submit Quiz",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔒 LOGIC UNCHANGED
  Future<void> submitQuiz() async {
    final userId = await UserSession.getOrCreateUserId();

    final res = await ApiService.submitQuiz(
      userId: userId,
      quizId: widget.quiz.quizId,
      answers: answers,
    );

    final result = QuizResult.fromJson(res);

    widget.homeViewModel.applyQuizResult(
      xpGained: result.xpGained,
      streak: result.streak,
    );

    Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => QuizResultScreen(
      result: result,
      onDone: () {
        widget.homeViewModel.applyQuizResult(
          xpGained: result.xpGained,
          streak: result.streak,
        );
      },
    ),
  ),
);

  }
}
