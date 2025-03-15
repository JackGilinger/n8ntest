// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class SettingsScreen extends StatefulWidget {
  final double width;
  final double height;
  const SettingsScreen({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;
  String selectedLanguage = 'Русский';
  TimeOfDay reminderTime = const TimeOfDay(hour: 20, minute: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text(
              'Общие настройки',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SwitchListTile(
            title: const Text('Темная тема'),
            value: isDarkMode,
            onChanged: (value) {
              setState(() {
                isDarkMode = value;
              });
            },
          ),
          ListTile(
            title: const Text('Язык'),
            trailing: DropdownButton<String>(
              value: selectedLanguage,
              items: ['Русский', 'English'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedLanguage = newValue!;
                });
              },
            ),
          ),
          const Divider(),
          const ListTile(
            title: Text(
              'Уведомления',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SwitchListTile(
            title: const Text('Включить уведомления'),
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
          ),
          ListTile(
            title: const Text('Время напоминания'),
            trailing: Text(reminderTime.format(context)),
            onTap: () async {
              final TimeOfDay? newTime = await showTimePicker(
                context: context,
                initialTime: reminderTime,
              );
              if (newTime != null) {
                setState(() {
                  reminderTime = newTime;
                });
              }
            },
          ),
          const Divider(),
          const ListTile(
            title: Text(
              'Данные',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text('Экспорт данных'),
            trailing: const Icon(Icons.download),
            onTap: () {
              // TODO: Implement export functionality
            },
          ),
          ListTile(
            title: const Text('Резервное копирование'),
            trailing: const Icon(Icons.backup),
            onTap: () {
              // TODO: Implement backup functionality
            },
          ),
          const Divider(),
          const ListTile(
            title: Text(
              'О приложении',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            title: const Text('Версия'),
            trailing: const Text('1.0.0'),
          ),
          ListTile(
            title: const Text('Политика конфиденциальности'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // TODO: Open privacy policy
            },
          ),
          ListTile(
            title: const Text('Условия использования'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // TODO: Open terms of service
            },
          ),
        ],
      ),
    );
  }
}
