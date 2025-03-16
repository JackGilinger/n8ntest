// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '../models/emotion_record.dart';

class EmotionPicker extends StatelessWidget {
  final EmotionType? selectedEmotion;
  final Function(EmotionType) onEmotionSelected;

  const EmotionPicker({
    Key? key,
    this.selectedEmotion,
    required this.onEmotionSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Выберите эмоцию',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: EmotionType.values.map((emotionType) {
            // Создаем временную запись для получения цвета и эмодзи
            final tempEmotion = EmotionRecord(
              id: '',
              emotionType: emotionType,
              intensity: 3,
              description: '',
              tags: const [],
              createdAt: DateTime.now(),
            );

            final isSelected = selectedEmotion == emotionType;

            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  try {
                    onEmotionSelected(emotionType);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 80,
                  height: 100,
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? tempEmotion.getColor().withOpacity(0.2)
                        : Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? tempEmotion.getColor()
                          : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        tempEmotion.emoji,
                        style: const TextStyle(fontSize: 32),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        tempEmotion.getLocalizedName(context),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: isSelected
                              ? FontWeight.w500
                              : FontWeight.normal,
                          color: isSelected
                              ? tempEmotion.getColor()
                              : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class IntensityPicker extends StatelessWidget {
  final int selectedIntensity;
  final Function(int) onIntensitySelected;
  final EmotionType emotionType;

  const IntensityPicker({
    Key? key,
    required this.selectedIntensity,
    required this.onIntensitySelected,
    required this.emotionType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Создаем временную запись для получения цвета
    final tempEmotion = EmotionRecord(
      id: '',
      emotionType: emotionType,
      intensity: 3,
      description: '',
      tags: const [],
      createdAt: DateTime.now(),
    );

    final color = tempEmotion.getColor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Интенсивность',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            5,
            (index) {
              final intensity = index + 1;
              final isSelected = selectedIntensity == intensity;

              return GestureDetector(
                onTap: () {
                  try {
                    onIntensitySelected(intensity);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(e.toString())),
                    );
                  }
                },
                child: Column(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? color.withOpacity(0.2)
                            : Colors.grey[50],
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? color : Colors.grey[300]!,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '$intensity',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: isSelected
                                ? FontWeight.w500
                                : FontWeight.normal,
                            color: isSelected ? color : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _getIntensityLabel(intensity),
                      style: TextStyle(
                        fontSize: 12,
                        color: isSelected ? color : Colors.black54,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  String _getIntensityLabel(int intensity) {
    switch (intensity) {
      case 1:
        return 'Очень слабо';
      case 2:
        return 'Слабо';
      case 3:
        return 'Средне';
      case 4:
        return 'Сильно';
      case 5:
        return 'Очень сильно';
      default:
        return '';
    }
  }
}