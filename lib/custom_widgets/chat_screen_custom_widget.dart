import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';

// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Additional imports for animations and timers

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

  // Function to handle sending messages and animation
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
      animationController.forward(from: 0.0);
    });

    final typingIndicator = {
      'text': 'Assistant typing...',
      'isTyping': true,
      'tag': uuid.v4(),
    };

    setState(() {
      messages.add(typingIndicator);
      animationController.forward(from: 0.0);
    });

    Timer(const Duration(seconds: 1), () {
      setState(() {
        messages.remove(typingIndicator);
        messages.add({
          'text': 'This is a mock response from assistant.',
          'isUser': false,
          'tag': uuid.v4(),
        });
        animationController.forward(from: 0.0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD), // Improved background color
      appBar: AppBar(
        title: const Text('GChat'),
        backgroundColor: Colors.blueAccent,
        elevation: 1,
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
                ).animate().fadeIn(duration: 300.ms);
              },
            ),
          ),
          _chatInputArea().animate().slideY(duration: 500.ms, begin: 1, end: 0)
        ],
      ),
    );
  }

  Widget _buildChatBubble(String message, bool isUser, {bool isTyping = false}) {
    return Align(
      alignment: isUser ? Alignment.topRight : Alignment.topLeft,
      child: Container(
        padding:const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        margin:const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isUser ? Colors.blueAccent : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(isUser ? 18 : 0),
            bottomRight: Radius.circular(isUser ? 0 : 18),
          ),
          boxShadow: [
            BoxShadow(color: Colors.grey.shade200, blurRadius: 6)
          ],
        ),
        child: Text(
          isTyping ? '...' : message,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  Widget _chatInputArea() {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: textController,
              style: const TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                hintText: 'Write your message here...',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                contentPadding:const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueAccent,
            ),
            child: IconButton(
              icon:const Icon(Icons.send, color: Colors.white),
              onPressed: sendMessage,
            ),
          ),
        ],
      ),
    );
  }
}