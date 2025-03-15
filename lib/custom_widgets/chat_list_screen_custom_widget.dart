// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cached_network_image/cached_network_image.dart';

class ChatListScreenCustomWidget extends StatefulWidget {
  const ChatListScreenCustomWidget({
    super.key,
    this.width,
    this.height,
    this.onChatTap, // Added callback parameter
  });

  final double? width;
  final double? height;
  final Function(int)? onChatTap; // Callback for chat tap with index parameter

  @override
  State<ChatListScreenCustomWidget> createState() =>
      _ChatListScreenCustomWidgetState();
}

class _ChatListScreenCustomWidgetState
    extends State<ChatListScreenCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      appBar: AppBar(
        title: const Text('GChat'),
        backgroundColor: Colors.blueAccent,
        elevation: 1,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8), // Reduced vertical padding
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8), // Reduced vertical padding
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search chats...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Chat list
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Temporarily hardcoded
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  // Call the callback function if provided
                  if (widget.onChatTap != null) {
                    widget.onChatTap!(index);
                  }
                },
                child: ChatListItem(
                  avatarUrl: 'https://picsum.photos/100/100?random=$index',
                  name: 'User ${index + 1}',
                  lastMessage: 'Last message from user ${index + 1}',
                  timestamp: '${index + 1}m ago',
                  unreadCount: index % 3 == 0 ? index : 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatListItem extends StatelessWidget {
  final String avatarUrl;
  final String name;
  final String lastMessage;
  final String timestamp;
  final int unreadCount;

  const ChatListItem({
    super.key,
    required this.avatarUrl,
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    required this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              image: DecorationImage(
                image: CachedNetworkImageProvider(avatarUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Chat info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      timestamp,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        lastMessage,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (unreadCount > 0) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          unreadCount.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}