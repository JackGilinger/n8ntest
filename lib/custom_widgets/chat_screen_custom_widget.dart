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
        'timestamp': DateFormat('HH:mm').format(DateTime.now()),
      });

      animationController.forward(from: 0.0);

    Timer(Duration(seconds: 2), () {
      setState(() {
        messages.removeWhere((msg) => msg['isTyping'] == true);
        messages.add({
          'text': 'This is a mock response',
          'isUser': false,
          'tag': Uuid().v4(),
          'timestamp': DateFormat('HH:mm').format(DateTime.now()),
        });
      });
    });

    messages.add(userMessage);
    textController.clear();
  }

  late AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Chat'),
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
                bool isUserMsg = msg['isUser'] ?? false;
                bool isTypingIndicator = msg['isTyping'] ?? false;
                return Column(
                  crossAxisAlignment: isUserMsg
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    _chatBubble(
                      msg['text'],
                      isUserMsg,
                      isTyping: isTypingIndicator,
                    ).animate().fade(duration: 400.ms), // Плавная анимация для сообщений
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      child: Text(
                        msg['timestamp'],
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ),
              ].animate(interval: 100.ms);
              },
            ),
          ),
          chatInputArea(),
        ),
      );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: Duration(milliseconds: 400),
        child: Text('typing...',
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }

  Widget _buildTextBubble(String text, bool isUser, {bool isTyping = false}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color:...