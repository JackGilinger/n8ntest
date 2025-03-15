// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final Function(DateTime) onDateSelected;
  final Function(String) onEmotionSelected;
  final Function() onAddEmotion;
  final Function() onOpenSettings;

  const HomeScreen({
    Key? key,
    required this.onDateSelected,
    required this.onEmotionSelected,
    required this.onAddEmotion,
    required this.onOpenSettings,
  }) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Дневник эмоций'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: widget.onOpenSettings,
          ),
        ],
      ),
      body: Column(
        children: [
          // Calendar view replaced with a simplified date picker
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text(
              _selectedDay?.toString().split(' ')[0] ?? 
              DateTime.now().toString().split(' ')[0]
            ),
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _selectedDay ?? DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (picked != null) {
                setState(() {
                  _selectedDay = picked;
                  _focusedDay = picked;
                });
                widget.onDateSelected(picked);
              }
            },
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                // Example emotion card
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text('Emotion $index'),
                    subtitle: Text('Note for emotion $index'),
                    trailing: Text('$index'),
                    onTap: () => widget.onEmotionSelected('$index'),
                  ),
                );
              },
              itemCount: 10, // Example count
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onAddEmotion,
        child: const Icon(Icons.add),
      ),
    );
  }
}