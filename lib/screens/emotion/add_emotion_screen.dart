// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddEmotionScreen extends StatefulWidget {
  const AddEmotionScreen({Key? key}) : super(key: key);

  @override
  _AddEmotionScreenState createState() => _AddEmotionScreenState();
}

class _AddEmotionScreenState extends State<AddEmotionScreen> {
  final List<String> emotions = ['Радость', 'Грусть', 'Злость', 'Страх', 'Удивление'];
  String selectedEmotion = 'Радость';
  double intensityValue = 3;
  final TextEditingController _noteController = TextEditingController();
  bool _isLoading = false;
  String? _intensityError;

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _validateIntensity(double value) {
    setState(() {
      if (value < 1 || value > 5) {
        _intensityError = 'Интенсивность должна быть от 1 до 5';
      } else {
        _intensityError = null;
      }
      intensityValue = value;
    });
  }

  Future<void> _saveEmotion() async {
    if (_noteController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Пожалуйста, добавьте описание')),
      );
      return;
    }

    if (_intensityError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_intensityError!)),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('Пользователь не авторизован');

      await FirebaseFirestore.instance.collection('emotions').add({
        'userId': user.uid,
        'emotion': selectedEmotion,
        'intensity': intensityValue,
        'note': _noteController.text,
        'date': DateTime.now(),
        'timestamp': FieldValue.serverTimestamp(),
      });

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Новая запись'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Выберите эмоцию:',
              style: FlutterFlowTheme.of(context).bodyLarge,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: emotions.map((emotion) {
                return ChoiceChip(
                  label: Text(emotion),
                  selected: selectedEmotion == emotion,
                  onSelected: (selected) {
                    setState(() {
                      selectedEmotion = emotion;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text(
              'Интенсивность:',
              style: FlutterFlowTheme.of(context).bodyLarge,
            ),
            Slider(
              value: intensityValue,
              min: 1,
              max: 5,
              divisions: 4,
              label: intensityValue.round().toString(),
              onChanged: _validateIntensity,
            ),
            if (_intensityError != null)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  _intensityError!,
                  style: TextStyle(color: Colors.red[700], fontSize: 12),
                ),
              ),
            const SizedBox(height: 24),
            TextField(
              controller: _noteController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Описание ситуации',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveEmotion,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Сохранить'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}