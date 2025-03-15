import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ChatScreenWidget extends StatefulWidget {
  const ChatScreenWidget({super.key});

  @override
  _ChatScreenWidgetState createState() => _ChatScreenWidgetState();
}

class _ChatScreenWidgetState extends State<ChatScreenWidget> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F7FD),
      appBar: AppBar(
        title: const Text('OpenAI Chat', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF19C37D),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              children: [
                _buildChatBubble("Привет! Что ты хочешь сегодня узнать?", false)
                    .animate()
                    .fade(duration: 400.ms)
                    .moveY(begin: 20),
                _buildChatBubble(
                        "Приветствую, это тестовый UI от FlutterFlow.", true)
                    .animate()
                    .fade(delay: 400.ms, duration: 400.ms)
                    .moveY(begin: 20),
                _buildChatBubble("Отлично! Напиши свой вопрос сейчас.", false)
                    .animate()
                    .fade(delay: 800.ms, duration: 400.ms)
                    .moveY(begin: 20)
              ],
            ),
          ),
          _chatInputArea()
        ],
      ),
    );
  }

  Widget _buildChatBubble(String message, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color:
              isUser ? const Color(0xFF19C37D) : const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(18),
            topRight: const Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 18),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)
          ],
        ),
        child: Text(
          message,
          style: TextStyle(
              color: isUser ? Colors.white : Colors.black87, fontSize: 16),
        ),
      ),
    );
  }

  Widget _chatInputArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.02), blurRadius: 8)
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Введите ваше сообщение...',
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            backgroundColor: const Color(0xFF19C37D),
            child: IconButton(
              icon: const Icon(Icons.send_outlined, color: Colors.white),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}