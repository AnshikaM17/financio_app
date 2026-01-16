import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/chat_message.dart';

class ChatbotViewModel extends ChangeNotifier {
  static const String backendUrl = 'http://127.0.0.1:8000/chat';

  final List<ChatMessage> _messages = [
    ChatMessage(type: MessageType.bot, text: 'hi'),
  ];

  final TextEditingController inputController = TextEditingController();

  bool _isTyping = false;

  List<ChatMessage> get messages => _messages;
  bool get isTyping => _isTyping;

  Future<void> sendMessage(String language) async {
    final text = inputController.text.trim();
    if (text.isEmpty) return;

    _messages.add(ChatMessage(type: MessageType.user, text: text));
    inputController.clear();
    _isTyping = true;
    notifyListeners();

    final reply = await _sendToBackend(text, language);

    _messages.add(ChatMessage(type: MessageType.bot, text: reply));
    _isTyping = false;
    notifyListeners();
  }

  Future<String> _sendToBackend(String message, String language) async {
    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'message': message,
          'language': language,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Backend error');
      }

      final data = jsonDecode(response.body);
      return data['reply'];

    } catch (_) {
      return language == 'hi'
          ? 'सर्वर से जुड़ने में समस्या आ रही है। कृपया बाद में प्रयास करें।'
          : 'Unable to connect to the server. Please try again.';
    }
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }
}
