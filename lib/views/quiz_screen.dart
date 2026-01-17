import 'package:financio_app/models/quiz_result_model.dart';
import 'package:financio_app/views/quiz_result_screen.dart';
import 'package:flutter/material.dart';
import '../models/quiz_model.dart';
import '../core/api_service.dart';
import '../core/user_session.dart';

class QuizScreen extends StatefulWidget {
  final Quiz quiz;
  const QuizScreen({super.key, required this.quiz});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final Map<String, String> answers = {};

  String indexToLetter(int index) {
    return String.fromCharCode(65 + index); // 0->A, 1->B, 2->C, 3->D
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Today’s Question")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...widget.quiz.questions.map((q) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  q.question,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...List.generate(q.options.length, (i) {
                  return RadioListTile<int>(
                    value: i,
                    onChanged: (val) {
                      setState(() {
                        answers[q.id] = indexToLetter(val!);
                      });
                    },

                    title: Text(q.options[i]),
                  );
                }),
                const SizedBox(height: 24),
              ],
            );
          }),
          ElevatedButton(onPressed: submitQuiz, child: const Text("Submit")),
        ],
      ),
    );
  }

  Future<void> submitQuiz() async {
    final userId = await UserSession.getOrCreateUserId();

    final res = await ApiService.submitQuiz(
      userId: userId,
      quizId: widget.quiz.quizId,
      answers: answers,
    );

    final result = QuizResult.fromJson(res);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => QuizResultScreen(result: result)),
    );
  }
}
