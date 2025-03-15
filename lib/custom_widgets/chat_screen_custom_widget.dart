// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter_animate/flutter_animate.dart';
import 'dart:async';
import 'package:uuid/uuid.dart';

class ChatScreenWidget extends StatefulWidget {
  final double width;
  final double height;

  const ChatScreenWidget({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _ChatScreenWidgetState createState() => _ChatScreenWidgetState();
}

class _ChatScreenWidgetState extends State<ChatScreenWidget>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController textController = TextEditingController();
  final uuid = Uuid();
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
  }

  void sendMessage() {
    if (textController.text.trim().isEmpty) return;

    final userMessage = {
      'text': textController.text,
      'isUser': true,
      'tag': Uuid().v4(),
      'timestamp': DateFormat('HH:mm').format(DateTime.now()),
    };

    setState(() {
      messages.add(userMessage);
      textController.clear();
      messages.add({
        'text': 'typing...',
        'isTyping': true,
        'tag': Uuid().v4(),
        'timestamp': DateFormat('HH:mm').format(DateTime.now()),
      });

      Timer(Duration(seconds: 2), () {
        messages.removeWhere((msg) => msg['isTyping'] == true);

        messages.add({
          'text': 'This is a mock response',
          'isUser': false,
          'tag': Uuid().v4(),
          'timestamp': DateFormat('HH:mm').format(DateTime.now()),
        });
        animationController.forward(from: 0.0);
      });

    messages.add(userMessage);
    textController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('GChat'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
              final msg = messages[index];
              // Добавлена проверка на null для предотвращения ошибки в UI
              bool isUserMsg = msg['isUser'] ?? false;
              bool isTypingIndicator = msg['isTyping'] ?? false;

              return Column(
                  crossAxisAlignment: isUserMsg
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    _buildChatBubble(
                      msg['text'],
                      isUserMsg,
                      isTyping: isTypingIndicator,
                    ).animate().fadeIn(duration: 300.ms),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      msg['timestamp'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        _chatInputArea().animate().slideY(duration: 500.ms, begin: 1, end: 0),
      ],
    ),
   );
  }

  Widget _buildChatBubble(String text, bool isUser, {bool isTyping = false}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isUser ? Colors.blueAccent : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 0),
          ),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6)],
        ),
        child: Text(
          isTyping ? 'Typing...' : text,
          style: TextStyle(color: isUser ? Colors.white : Colors.black87, fontSize: 16),
        ),
      ),
    );
  }

  Widget _chatInputArea() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Type your message...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          SizedBox(width: 12),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blue),
            onPressed: sendMessage,
          ),
        ],
      ),
    );
  }
}