// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:intl/intl.dart';

class EmotionDiaryEntry extends StatefulWidget {
  const EmotionDiaryEntry({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;

  @override
  _EmotionDiaryEntryState createState() => _EmotionDiaryEntryState();
}

class _EmotionDiaryEntryState extends State<EmotionDiaryEntry> {
  final emotions = ['Радость', 'Грусть', 'Злость', 'Спокойствие', 'Тревога'];
  int selectedEmotionIndex = -1;
  final TextEditingController _noteController = TextEditingController();
  int selectedIntensity = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat('dd MMMM yyyy').format(DateTime.now()),
            style: FlutterFlowTheme.of(context).titleMedium,
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: List.generate(
              emotions.length,
              (index) => ChoiceChip(
                label: Text(emotions[index]),
                selected: selectedEmotionIndex == index,
                onSelected: (selected) {
                  setState(() {
                    selectedEmotionIndex = selected ? index : -1;
                  });
                },
                selectedColor: FlutterFlowTheme.of(context).primary,
                labelStyle: TextStyle(
                  color: selectedEmotionIndex == index
                      ? Colors.white
                      : FlutterFlowTheme.of(context).primaryText,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Интенсивность',
            style: FlutterFlowTheme.of(context).bodyMedium,
          ),
          Slider(
            value: selectedIntensity.toDouble(),
            min: 1,
            max: 5,
            divisions: 4,
            label: selectedIntensity.toString(),
            onChanged: (value) {
              setState(() {
                selectedIntensity = value.round();
              });
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _noteController,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Опишите ситуацию...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  _noteController.clear();
                  setState(() {
                    selectedEmotionIndex = -1;
                    selectedIntensity = 3;
                  });
                },
                child: Text(
                  'Очистить',
                  style: FlutterFlowTheme.of(context).bodyMedium?.copyWith(
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  // TODO: Implement save logic
                },
                child: const Text('Сохранить'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}