import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart';
import '/flutter_flow/custom_functions.dart';
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

    final messageId = uuid.v4();
    final userMessage = {
      'text': textController.text,
      'isUser': true,
      'tag': uuid.v4(),
      'timestamp': DateFormat('HH:mm').format(DateTime.now()),
    };

    setState(() {
      messages.add(userMessage);
      textController.clear();
    });

    final typingIndicator = {
      'text': 'Assistant typing...',
      'isUser': false,
      'isTyping': true,
      'tag': uuid.v4(),
      'timestamp': DateFormat('HH:mm').format(DateTime.now()),
    };

    setState(() {
      messages.add(typingIndicator);
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        messages.remove(typingIndicator);
        messages.add({
          'text': 'This is a response from demo.',
          'isUser': false,
          'tag': uuid.v4(),
          'timestamp': DateFormat('HH:mm').format(DateTime.now()),
        });
      });
    });

    textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GChat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                bool isUser = msg['isUser'] ?? false;
                return Column(
                  crossAxisAlignment: isUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    _chatBubble(msg['text'], isUser)
                        .animate()
                        .fadeIn(duration: 300.ms),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                        msg['timestamp'],
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
          _chatInputArea().animate().slideY(
                duration: 500,
              ),
        ],
      ),
    );
  }

  Widget _chatBubble(String message, bool isUser,
      {bool isTyping = false}) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isUser ? Colors.blueAccent : Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey.shade200, blurRadius: 6),
          ],
          borderRadius: BorderRadius.circular(16),
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

  Widget _chatInputArea() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              decoration: const InputDecoration(
                hintText: 'Write your message here...',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}