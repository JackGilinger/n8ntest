// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

enum EmotionType {
  joy,
  sadness,
  anger,
  fear,
  surprise,
}

class EmotionRecord {
  final String id;
  final EmotionType emotionType;
  final int intensity; // 1-5
  final String description;
  final List<String> tags;
  final DateTime createdAt;
  final DateTime? updatedAt;

  EmotionRecord({
    required this.id,
    required this.emotionType,
    required this.intensity,
    required this.description,
    required this.tags,
    required this.createdAt,
    this.updatedAt,
  });

  // Create a copy of the current EmotionRecord with specified new fields
  EmotionRecord copyWith({
    String? id,
    EmotionType? emotionType,
    int? intensity,
    String? description,
    List<String>? tags,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EmotionRecord(
      id: id ?? this.id,
      emotionType: emotionType ?? this.emotionType,
      intensity: intensity ?? this.intensity,
      description: description ?? this.description,
      tags: tags ?? this.tags,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // Convert EmotionRecord to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'emotionType': emotionType.toString().split('.').last,
      'intensity': intensity,
      'description': description,
      'tags': tags,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
    };
  }

  // Create an EmotionRecord from a Map
  factory EmotionRecord.fromMap(Map<String, dynamic> map) {
    return EmotionRecord(
      id: map['id'],
      emotionType: EmotionType.values.firstWhere(
        (e) => e.toString().split('.').last == map['emotionType'],
        orElse: () => EmotionType.joy,
      ),
      intensity: map['intensity'],
      description: map['description'],
      tags: List<String>.from(map['tags']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']),
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'])
          : null,
    );
  }

  // Get emoji for emotion type
  String get emoji {
    switch (emotionType) {
      case EmotionType.joy:
        return '😊';
      case EmotionType.sadness:
        return '😢';
      case EmotionType.anger:
        return '😡';
      case EmotionType.fear:
        return '😨';
      case EmotionType.surprise:
        return '😲';
    }
  }

  // Get localized name for emotion type
  String getLocalizedName(BuildContext context) {
    switch (emotionType) {
      case EmotionType.joy:
        return 'Радость';
      case EmotionType.sadness:
        return 'Грусть';
      case EmotionType.anger:
        return 'Злость';
      case EmotionType.fear:
        return 'Страх';
      case EmotionType.surprise:
        return 'Удивление';
    }
  }

  // Get color for emotion type
  Color getColor() {
    switch (emotionType) {
      case EmotionType.joy:
        return Colors.yellow.shade600;
      case EmotionType.sadness:
        return Colors.blue.shade400;
      case EmotionType.anger:
        return Colors.red.shade400;
      case EmotionType.fear:
        return Colors.purple.shade300;
      case EmotionType.surprise:
        return Colors.green.shade400;
    }
  }
}