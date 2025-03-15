// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class StatisticsScreen extends StatefulWidget {
  final double width;
  final double height;
  final Future Function(String period) onPeriodChanged;

  const StatisticsScreen({
    Key? key,
    required this.width,
    required this.height,
    required this.onPeriodChanged,
  }) : super(key: key);

  @override
  _StatisticsScreenState createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with TickerProviderStateMixin {
  String selectedPeriod = 'week';

  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        title: const Text('Статистика'),
        elevation: 2,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                selectedPeriod = value;
              });
              widget.onPeriodChanged(value);
              _controller.forward(from: 0.0);
            },
            itemBuilder: (context) => [
              PopupMenuItem<String>(
                value: 'day',
                child: Row(
                  children: [
                    Icon(Icons.today,
                        color: FlutterFlowTheme.of(context).primary),
                    const SizedBox(width: 12),
                    const Text('День'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'week',
                child: Row(
                  children: [
                    Icon(Icons.view_week,
                        color: FlutterFlowTheme.of(context).primary),
                    const SizedBox(width: 12),
                    const Text('Неделя'),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'month',
                child: Row(
                  children: [
                    Icon(Icons.calendar_month,
                        color: FlutterFlowTheme.of(context).primary),
                    const SizedBox(width: 12),
                    const Text('Месяц'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            children: [
              // Emotions distribution card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.pie_chart,
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Распределение эмоций',
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Emotions intensity card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.show_chart,
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Интенсивность эмоций',
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Frequently used tags card
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.label,
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Часто используемые теги',
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          for (final tag in [
                            'Работа (5)',
                            'Семья (3)',
                            'Спорт (2)'
                          ])
                            Chip(
                              label: Text(tag),
                              backgroundColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              labelStyle:
                                  FlutterFlowTheme.of(context).bodyMedium,
                              elevation: 2,
                              padding: const EdgeInsets.all(8),
                            ),
                        ],
                      ),
                    ],
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
// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
