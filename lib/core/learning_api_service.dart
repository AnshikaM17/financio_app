import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/lesson_model.dart';

class LearningApiService {
  static const baseUrl =
      'http://localhost:3000';

  static Future<void> generateLesson({
    required String topic,
    required String level,
  }) async {
    await http.get(
      Uri.parse(
        '$baseUrl/generate?topic=${Uri.encodeComponent(topic)}&level=$level',
      ),
    );
  }

  static Future<Lesson> loadLesson({
    required String topic,
    required String level,
  }) async {
    final res = await http.get(
      Uri.parse(
        '$baseUrl/lesson?topic=${Uri.encodeComponent(topic)}&level=$level',
      ),
    );

    if (res.statusCode != 200) {
      throw Exception('Lesson load failed');
    }

    return Lesson.fromJson(json.decode(res.body));
  }
}
