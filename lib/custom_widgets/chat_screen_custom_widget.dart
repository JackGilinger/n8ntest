import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:flutter/material.dart';

class ChatScreenCustomWidget extends StatefulWidget {
  final double width;
  final double height;
  final bool? showTypingIndicator;

  const ChatScreenCustomWidget({
    Key? key,
    required this.width,
    required this.height,
    this.showTypingIndicator,
  }) : super(key: key);

  @override
  _ChatScreenCustomWidgetState createState() => _ChatScreenCustomWidgetState();
}

class _ChatScreenCustomWidgetState extends State<ChatScreenCustomWidget> {

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    if (widget.showTypingIndicator ?? false) {
      widgets.add(
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: const Text("печатает...",
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
        ),
      );
    }

    return Container(
      width: widget.width,
      height: widget.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }
}