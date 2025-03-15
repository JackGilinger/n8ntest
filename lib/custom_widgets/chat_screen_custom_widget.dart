// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Additional imports for handling animations, uuid for random tagging, timers.
import 'package:flutter_animate/flutter_animate.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';

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

class _ChatScreenWidgetState extends State<ChatScreenWidget> {
  final List<Map<String, dynamic>> messages = [];
  final TextEditingController textController = TextEditingController();
  final uuid = Uuid();

  // Mock function to handle sending a message
  void sendMessage() {
    if (textController.text.isEmpty) return;

    final userMessage = {
      'text': textController.text,
      'isUser': true,
      'tag': uuid.v4(),
    };

    setState(() {
      messages.add(userMessage);
      textController.clear();
    });

    // Mock "assistant is typing" indicator
    final typingIndicator = {
      'text': 'Assistant typing...',
      'isTyping': true,
      'tag': uuid.v4(),
    };

    setState(() {
      messages.add(typingIndicator);
    });

    // Mock assistant response after 1-second delay
    Timer(const Duration(seconds: 1), () {
      setState(() {
        messages.remove(typingIndicator);
        messages.add({
          'text': 'This is a mock response from assistant.',
          'isUser': false,
          'tag': uuid.v4(),
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF3F7FD),
      appBar: AppBar(
        title: const Text('GChat'),
        backgroundColor: Colors.white.withOpacity(0.7), // translucent blur effect
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                return _buildChatBubble(
                  msg['text'],
                  msg['isUser'] ?? false,
                  isTyping: msg['isTyping'] ?? false,
                );
              },
            ),
          ),
          _chatInputArea()
        ],
      ),
    );
  }

  Widget _buildChatBubble(String message, bool isUser, {bool isTyping = false}) {
    return Align(
      alignment: isUser ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isUser ? const Color(0xFFF19C37D) : const Color(0xFFFFFFFF),
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
          isTyping ? '...' : message,
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
              ),
              child: TextField(
                controller: textController,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  hintText: 'Write your message here...',
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            backgroundColor: const Color(0xFFF19C37D),
            child: IconButton(
              icon: const Icon(Icons.send_outlined, color: Colors.white),
              onPressed: sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!