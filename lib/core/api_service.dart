import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://mitra-learning-backend.onrender.com';

  static Future<Map<String, dynamic>> getDailyHabit({
    required String userId,
    required String language,
    required String profession,
  }) async {
    final uri = Uri.parse(
      '$baseUrl/habit/daily'
      '?user_id=$userId'
      '&language=$language'
      '&profession=$profession',
    );

    final res = await http.get(uri);
    return jsonDecode(res.body);
  }

  static Future<void> completeHabit({
    required String userId,
    required String habitId,
  }) async {
    await http.post(
      Uri.parse('$baseUrl/habit/complete'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'habit_id': habitId,
      }),
    );
  }

  static Future<Map<String, dynamic>> generateQuiz({
    required String userId,
    required String language,
    required String profession,
  }) async {
    final res = await http.post(
      Uri.parse('$baseUrl/quiz/generate'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'quiz_type': 'general',
        'language': language,
        'profession': profession,
      }),
    );

    return jsonDecode(res.body);
  }

  static Future<Map<String, dynamic>> submitQuiz({
    required String userId,
    required String quizId,
    required Map<String, String> answers, // ✅ LETTERS
  }) async {
    final res = await http.post(
      Uri.parse('$baseUrl/quiz/submit'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'user_id': userId,
        'quiz_id': quizId,
        'answers': answers,
      }),
    );

    return jsonDecode(res.body);
  }
}

