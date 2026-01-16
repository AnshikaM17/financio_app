import 'package:financio_app/utils/widgets/language_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/chatbot_viewmodel.dart';
import '../viewmodels/home_viewmodel.dart';
import '../models/chat_message.dart';

class MitraChatScreen extends StatelessWidget {
  const MitraChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final language = context.watch<HomeViewModel>().language;

    return ChangeNotifierProvider(
      create: (_) => ChatbotViewModel(),
      child: _MitraChatContent(language: language),
    );
  }
}

class _MitraChatContent extends StatefulWidget {
  final String language;
  const _MitraChatContent({required this.language});

  @override
  State<_MitraChatContent> createState() => _MitraChatContentState();
}

class _MitraChatContentState extends State<_MitraChatContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void didUpdateWidget(covariant _MitraChatContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ChatbotViewModel>();
    final homeVm = context.watch<HomeViewModel>();

    _scrollToBottom();

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Column(
        children: [
          /// 🔝 HEADER
          Container(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF22C55E),
                  Color(0xFF16A34A),
                ],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '🤖 Mitra AI',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '24/7 Financial Assistant',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                LanguageDropdown(
                  value: homeVm.language,
                  onChanged: homeVm.changeLanguage,
                ),
              ],
            ),
          ),

          /// 💬 CHAT AREA
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: vm.messages.length + (vm.isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (vm.isTyping && index == vm.messages.length) {
                  return const _TypingIndicator();
                }

                final msg = vm.messages[index];
                String displayText = msg.text;

                if (msg.type == MessageType.bot && msg.text == 'hi') {
                  displayText = widget.language == 'hi'
                      ? 'नमस्ते! मैं मित्रा हूँ। मैं आपकी कैसे मदद कर सकता हूँ?'
                      : 'Hello! I am Mitra. How can I help you today?';
                }

                return Align(
                  alignment: msg.type == MessageType.user
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(14),
                    constraints:
                        const BoxConstraints(maxWidth: 300),
                    decoration: BoxDecoration(
                      color: msg.type == MessageType.user
                          ? const Color(0xFF22C55E)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black12,
                        ),
                      ],
                    ),
                    child: Text(
                      displayText,
                      style: TextStyle(
                        color: msg.type == MessageType.user
                            ? Colors.white
                            : Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          /// ⌨️ INPUT BAR
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.black12)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: vm.inputController,
                    onSubmitted: (_) =>
                        vm.sendMessage(widget.language),
                    decoration: InputDecoration(
                      hintText: widget.language == 'hi'
                          ? 'यहाँ लिखें...'
                          : 'Type here...',
                      filled: true,
                      fillColor: const Color(0xFFF3F4F6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send,
                      color: Colors.green),
                  onPressed: () =>
                      vm.sendMessage(widget.language),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, bottom: 12),
      child: Row(
        children: const [
          _Dot(),
          SizedBox(width: 4),
          _Dot(delay: 150),
          SizedBox(width: 4),
          _Dot(delay: 300),
        ],
      ),
    );
  }
}

class _Dot extends StatelessWidget {
  final int delay;
  const _Dot({this.delay = 0});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.3, end: 1),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      builder: (context, value, _) {
        return Opacity(
          opacity: value,
          child: const CircleAvatar(
            radius: 4,
            backgroundColor: Colors.grey,
          ),
        );
      },
    );
  }
}
