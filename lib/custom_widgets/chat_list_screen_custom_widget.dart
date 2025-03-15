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
  });

  final double? width;
  final double? height;

  @override
  State<ChatListScreenCustomWidget> createState() =>
      _ChatListScreenCustomWidgetState();
}

class _ChatListScreenCustomWidgetState
    extends State<ChatListScreenCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: FlutterFlowTheme.of(context).secondaryBackground,
      child: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).primaryBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search chats...',
                  prefixIcon: Icon(
                    Icons.search,
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
            ),
          ),
          // Chat list
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Temporarily hardcoded
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) => ChatListItem(
                avatarUrl: 'https://picsum.photos/100/100?random=$index',
                name: 'User ${index + 1}',
                lastMessage: 'Last message from user ${index + 1}',
                timestamp: '${index + 1}m ago',
                unreadCount: index % 3 == 0 ? index : 0,
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: FlutterFlowTheme.of(context).primaryBackground,
            width: 1,
          ),
        ),
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
                      style: FlutterFlowTheme.of(context).bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    Text(
                      timestamp,
                      style: FlutterFlowTheme.of(context).bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        lastMessage,
                        style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                              color: FlutterFlowTheme.of(context).secondaryText,
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
                          color: FlutterFlowTheme.of(context).primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          unreadCount.toString(),
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .copyWith(color: Colors.white),
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