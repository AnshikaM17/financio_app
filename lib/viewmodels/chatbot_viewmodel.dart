import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tts/flutter_tts.dart';

import '../models/chat_message.dart';

class ChatbotViewModel extends ChangeNotifier {
  static const String backendUrl =
      'https://mitra-backend-yau8.onrender.com/chat';

  final FlutterTts _tts = FlutterTts();

  final List<ChatMessage> _messages = [
    ChatMessage(type: MessageType.bot, text: 'hi'),
  ];

  final TextEditingController inputController = TextEditingController();

  bool _isTyping = false;
  bool _isSpeaking = false;

  List<ChatMessage> get messages => _messages;
  bool get isTyping => _isTyping;
  bool get isSpeaking => _isSpeaking;

  ChatbotViewModel() {
    _initTts();
  }

  /// 🔊 TTS SETUP
  Future<void> _initTts() async {
    await _tts.setSpeechRate(0.45);
    await _tts.setPitch(1.0);
    await _tts.setVolume(1.0);

    _tts.setCompletionHandler(() {
      _isSpeaking = false;
      notifyListeners();
    });
  }

  /// 🔊 SPEAK TEXT
  Future<void> speak(String text, String language) async {
    if (_isSpeaking) {
      await _tts.stop();
      _isSpeaking = false;
      notifyListeners();
      return;
    }

    await _tts.setLanguage(_mapLanguage(language));
    _isSpeaking = true;
    notifyListeners();

    await _tts.speak(text);
  }

  /// 🌍 LANGUAGE MAP
  String _mapLanguage(String lang) {
    switch (lang) {
      case 'hi':
        return 'hi-IN';
      case 'en':
        return 'en-US';
      case 'ta':
        return 'ta-IN';
      case 'te':
        return 'te-IN';
      case 'bn':
        return 'bn-IN';
      case 'mr':
        return 'mr-IN';
      default:
        return 'en-US';
    }
  }

  /// 💬 SEND MESSAGE
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

  /// 🌐 BACKEND CALL
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
    _tts.stop();
    inputController.dispose();
    super.dispose();
  }
}