// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:fl_chart/fl_chart.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({Key? key}) : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  String selectedPeriod = 'week';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                selectedPeriod = value;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'day',
                child: Text('День'),
              ),
              const PopupMenuItem(
                value: 'week',
                child: Text('Неделя'),  
              ),
              const PopupMenuItem(
                value: 'month',
                child: Text('Месяц'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Распределение эмоций',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: PieChart(
                        PieChartData(
                          sections: [
                            PieChartSectionData(
                              value: 35,
                              title: 'Радость',
                              color: Colors.green,
                            ),
                            PieChartSectionData(
                              value: 25,
                              title: 'Грусть',
                              color: Colors.blue,
                            ),
                            PieChartSectionData(
                              value: 20,
                              title: 'Злость',
                              color: Colors.red,
                            ),
                            PieChartSectionData(
                              value: 20,
                              title: 'Другие',
                              color: Colors.grey,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Интенсивность эмоций',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: true),
                          titlesData: FlTitlesData(show: true),
                          borderData: FlBorderData(
                            show: true,
                            border: Border.all(color: const Color(0xff37434d)),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: const [
                                FlSpot(0, 3),
                                FlSpot(1, 2),
                                FlSpot(2, 5),
                                FlSpot(3, 3.1),
                                FlSpot(4, 4),
                              ],
                              isCurved: true,
                              color: Colors.blue,
                              barWidth: 3,
                              dotData: FlDotData(show: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Часто используемые теги',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(label: Text('Работа (23)')),
                        Chip(label: Text('Семья (18)')),
                        Chip(label: Text('Спорт (15)')),
                        Chip(label: Text('Отдых (12)')),
                        Chip(label: Text('Друзья (10)')),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}