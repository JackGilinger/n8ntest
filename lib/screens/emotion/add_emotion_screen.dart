// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class AddEmotionScreen extends StatefulWidget {
  final double width;
  final double height;
  final Future Function(String emotion, double intensity, String note)
      onSaveEmotion;

  const AddEmotionScreen({
    Key? key,
    required this.width,
    required this.height,
    required this.onSaveEmotion,
  }) : super(key: key);

  @override
  _AddEmotionScreenState createState() => _AddEmotionScreenState();
}

class _AddEmotionScreenState extends State<AddEmotionScreen> {
  final List<String> emotions = [
    'Радость',
    'Печаль',
    'Гнев',
    'Страх',
    'Спокойствие'
  ];
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
        _intensityError = 'Значение должно быть от 1 до 5';
      } else {
        _intensityError = null;
      }
      intensityValue = value;
    });
  }

  Future<void> _saveEmotion() async {
    if (_noteController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Пожалуйста, введите комментарий')),
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
      await widget.onSaveEmotion(
        selectedEmotion,
        intensityValue,
        _noteController.text,
      );
      if (mounted) Navigator.pop(context);
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
        title: const Text('Добавить эмоцию'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Выберите эмоцию:',
              style: FlutterFlowTheme.of(context).titleMedium,
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
                  selectedColor: FlutterFlowTheme.of(context).primary,
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text(
              'Интенсивность:',
              style: FlutterFlowTheme.of(context).titleMedium,
            ),
            Slider(
              value: intensityValue,
              min: 1,
              max: 5,
              divisions: 4,
              activeColor: FlutterFlowTheme.of(context).primary,
              label: intensityValue.round().toString(),
              onChanged: _validateIntensity,
            ),
            if (_intensityError != null)
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Text(
                  _intensityError!,
                  style: TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            const SizedBox(height: 24),
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Комментарий',
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: FlutterFlowTheme.of(context).primary),
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveEmotion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: FlutterFlowTheme.of(context).primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Сохранить',
                        style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}