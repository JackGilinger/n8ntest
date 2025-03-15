// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

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
        title: const Text('Дневник эмоций'),
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: widget.onOpenSettings,
          ),
        ],
      ),
      body: Column(
        children: [
          // Enhanced date picker
          Card(
            margin: const EdgeInsets.all(12),
            elevation: 4,
            child: InkWell(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDay ?? DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: FlutterFlowTheme.of(context).primary,
                          onPrimary: FlutterFlowTheme.of(context).primaryText,
                          surface: FlutterFlowTheme.of(context).secondaryBackground,
                          onSurface: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                
                if (picked != null) {
                  setState(() {
                    _selectedDay = picked;
                    _focusedDay = picked;
                  });
                  widget.onDateSelected(picked);
                  _controller.forward(from: 0.0);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _selectedDay?.toString().split(' ')[0] ?? 
                          DateTime.now().toString().split(' ')[0],
                          style: FlutterFlowTheme.of(context).titleMedium,
                        ),
                      ],
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: FlutterFlowTheme.of(context).secondaryText,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Emotions list with animation
          Expanded(
            child: FadeTransition(
              opacity: _animation,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    elevation: 2,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '😊',
                            style: TextStyle(
                              fontSize: 24,
                              color: FlutterFlowTheme.of(context).primaryText,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        'Emotion $index',
                        style: FlutterFlowTheme.of(context).titleMedium,
                      ),
                      subtitle: Text(
                        'Note for emotion $index',
                        style: FlutterFlowTheme.of(context).bodyMedium,
                      ),
                      trailing: Text(
                        '$index',
                        style: FlutterFlowTheme.of(context).labelLarge?.copyWith(
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                      onTap: () => widget.onEmotionSelected('$index'),
                    ),
                  );
                },
                itemCount: 10,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: widget.onAddEmotion,
        elevation: 8,
        backgroundColor: FlutterFlowTheme.of(context).primary,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}