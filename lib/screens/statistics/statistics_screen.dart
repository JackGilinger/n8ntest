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
  final Function(String) onPeriodChanged;
  final Map<String, double> emotionDistribution;
  final List<Map<String, dynamic>> intensityData;
  final List<Map<String, int>> tagFrequency;

  const StatisticsScreen({
    Key? key,
    required this.onPeriodChanged,
    required this.emotionDistribution,
    required this.intensityData,
    required this.tagFrequency,
  }) : super(key: key);

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
              widget.onPeriodChanged(value);
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
                          sections: widget.emotionDistribution.entries.map((entry) {
                            return PieChartSectionData(
                              value: entry.value,
                              title: entry.key,
                              color: _getColorForEmotion(entry.key),
                            );
                          }).toList(),
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
                              spots: widget.intensityData.asMap().entries.map((entry) {
                                return FlSpot(
                                  entry.key.toDouble(), 
                                  entry.value['intensity']?.toDouble() ?? 0
                                );
                              }).toList(),
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
                      children: widget.tagFrequency.map((tag) {
                        return Chip(
                          label: Text('${tag['tag']} (${tag['count']})'),
                        );
                      }).toList(),
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

  Color _getColorForEmotion(String emotion) {
    switch (emotion.toLowerCase()) {
      case 'радость':
        return Colors.green;
      case 'грусть':
        return Colors.blue;
      case 'злость':
        return Colors.red;
      case 'страх':
        return Colors.purple;
      case 'удивление':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}