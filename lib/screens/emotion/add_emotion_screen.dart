// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:flutter/services.dart';

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
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: FlutterFlowTheme.of(context).error,
          margin: const EdgeInsets.all(16),
          content: const Text(
            'Пожалуйста, введите комментарий',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      return;
    }

    if (_intensityError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: FlutterFlowTheme.of(context).error,
          margin: const EdgeInsets.all(16),
          content: Text(
            _intensityError!,
            style: const TextStyle(color: Colors.white),
          ),
        ),
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
          SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: FlutterFlowTheme.of(context).error,
            margin: const EdgeInsets.all(16),
            content: Text(
              'Ошибка: $e',
              style: const TextStyle(color: Colors.white),
            ),
          ),
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
    final theme = FlutterFlowTheme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить эмоцию'),
        elevation: 0,
        backgroundColor: theme.primaryBackground,
        foregroundColor: theme.primaryText,
      ),
      body: Container(
        color: theme.primaryBackground,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Выберите эмоцию:',
                style: theme.titleMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: emotions.map((emotion) {
                  final isSelected = selectedEmotion == emotion;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: ChoiceChip(
                      label: Text(
                        emotion,
                        style: TextStyle(
                          color: isSelected ? Colors.white : theme.primaryText,
                          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        setState(() {
                          selectedEmotion = emotion;
                        });
                        HapticFeedback.lightImpact();
                      },
                      selectedColor: theme.primary,
                      backgroundColor: theme.secondaryBackground,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              Text(
                'Интенсивность:',
                style: theme.titleMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (index) {
                      return Text(
                        '${index + 1}',
                        style: theme.bodySmall,
                      );
                    }),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 6,
                      activeTrackColor: theme.primary,
                      inactiveTrackColor: theme.alternate.withOpacity(0.3),
                      thumbColor: theme.primary,
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 12,
                        elevation: 4,
                      ),
                      overlayColor: theme.primary.withOpacity(0.2),
                      overlayShape: RoundSliderOverlayShape(overlayRadius: 20),
                    ),
                    child: Slider(
                      value: intensityValue,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      label: intensityValue.round().toString(),
                      onChanged: _validateIntensity,
                    ),
                  ),
                ],
              ),
              if (_intensityError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8, left: 12),
                  child: Text(
                    _intensityError!,
                    style: TextStyle(
                      color: theme.error,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              const SizedBox(height: 32),
              TextField(
                controller: _noteController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Комментарий',
                  labelStyle: theme.bodyMedium,
                  hintText: 'Опишите, что вы испытываете...',
                  hintStyle: theme.bodyMedium.copyWith(color: theme.secondaryText.withOpacity(0.5)),
                  filled: true,
                  fillColor: theme.secondaryBackground,
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.alternate, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.primary, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.alternate, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveEmotion,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                    disabledBackgroundColor: theme.alternate,
                  ),
                  child: _isLoading
                      ? SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : Text(
                          'Сохранить',
                          style: theme.titleSmall.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}