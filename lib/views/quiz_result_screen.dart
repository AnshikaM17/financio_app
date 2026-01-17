import 'package:flutter/material.dart';
import '../models/quiz_result_model.dart';

class QuizResultScreen extends StatelessWidget {
  final QuizResult result;
  const QuizResultScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quiz Result")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Score: ${result.score}/${result.outOf}",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Text(
              "+${result.xpGained} XP 🎉",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),
            Text(
              "Streak: ${result.streak} 🔥",
              style: const TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 24),
            const Text(
              "Explanations",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            ...result.explanations.map(
              (e) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text("• $e"),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // back to Home
                },
                child: const Text("Back to Home"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
