enum MessageType { user, bot }

class ChatMessage {
  final MessageType type;
  final String text;

  ChatMessage({
    required this.type,
    required this.text,
  });
}
