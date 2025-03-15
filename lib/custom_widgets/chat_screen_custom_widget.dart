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
    if (textController.text.isEmpty) return;

    final userMessage = {
      'text': textController.text,
      'isUser': true,
      'tag': uuid.v4(),
      'timestamp': DateFormat('HH:mm').format(DateTime.now()),
    };

    setState(() {
      messages.add(userMessage);
      textController.clear();
      animationController.forward(from: 0.0);
    });

    final typingIndicator = {
      'text': 'Assistant typing...',
      'isTyping': true,
      'tag': uuid.v4(),
      'timestamp': DateFormat('HH:mm').format(DateTime.now()),
    };

    setState(() {
      messages.add(typingIndicator);
      animationController.forward(from: 0.0);
    });

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        messages.remove(typingIndicator);
        messages.add({
          'text': 'Response text',
          'isUser': false,
          'tag': uuid.v4(),
          'timestamp': DateFormat('HH:mm').format(DateTime.now()),
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('GChat'),
        backgroundColor: FlutterFlowTheme.primaryColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return Column(
                  crossAxisAlignment: msg['isUser'] == true
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    _chatBubble(
                      msg['text'],
                      msg['isUser'] == true,
                      isTyping: msg['isTyping'] == true,
                    ).animate().slideY(duration: 300.ms),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: Text(
                        msg['timestamp'],
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          _chatInputArea(),
        ],
      ),
    );
  }

  Widget _chatBubble(String message, bool isUser, {bool isTyping = false}) {
    return Align(
      alignment: isUser ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUser ? Colors.blueAccent : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 6)],
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}
```,
  