// Automatic FlutterFlow imports
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({
    Key? key,
    this.width,
    this.height,
    this.selectedDate,
    this.onDateSelected,
  }) : super(key: key);

  final double? width;
  final double? height;
  final DateTime? selectedDate;
  final Function(DateTime)? onDateSelected;

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _calendarFormat = CalendarFormat.month;
    _focusedDay = widget.selectedDate ?? DateTime.now();
    _selectedDay = widget.selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);
    
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.primaryText.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: TableCalendar(
        firstDay: DateTime.utc(2020, 1, 1),
        lastDay: DateTime.utc(2030, 12, 31),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        selectedDayPredicate: (day) {
          return isSameDay(_selectedDay, day);
        },
        onDaySelected: (selectedDay, focusedDay) {
          if (!isSameDay(_selectedDay, selectedDay)) {
            setState(() {
              _selectedDay = selectedDay;
              _focusedDay = focusedDay;
            });
            if (widget.onDateSelected != null) {
              widget.onDateSelected!(selectedDay);
            }
          }
        },
        onFormatChanged: (format) {
          if (_calendarFormat != format) {
            setState(() {
              _calendarFormat = format;
            });
          }
        },
        onPageChanged: (focusedDay) {
          _focusedDay = focusedDay;
        },
        calendarStyle: CalendarStyle(
          defaultTextStyle: theme.bodyMedium!.copyWith(
            fontSize: 14,
          ),
          weekendTextStyle: theme.bodyMedium!.copyWith(
            color: theme.error,
            fontSize: 14,
          ),
          selectedTextStyle: TextStyle(
            color: theme.primaryBackground,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          selectedDecoration: BoxDecoration(
            color: theme.primary,
            shape: BoxShape.circle,
          ),
          todayTextStyle: TextStyle(
            color: theme.primary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          todayDecoration: BoxDecoration(
            color: theme.primaryBackground,
            shape: BoxShape.circle,
            border: Border.all(
              color: theme.primary,
              width: 1.5,
            ),
          ),
          outsideTextStyle: theme.bodyMedium!.copyWith(
            color: theme.secondaryText.withOpacity(0.5),
            fontSize: 14,
          ),
          disabledTextStyle: theme.bodyMedium!.copyWith(
            color: theme.secondaryText.withOpacity(0.3),
            fontSize: 14,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: false,
          titleCentered: true,
          titleTextStyle: theme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          leftChevronIcon: Icon(
            Icons.chevron_left,
            color: theme.primary,
            size: 28,
          ),
          rightChevronIcon: Icon(
            Icons.chevron_right,
            color: theme.primary,
            size: 28,
          ),
          headerPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: theme.bodyMedium!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          weekendStyle: theme.bodyMedium!.copyWith(
            color: theme.error,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            return null; // TODO: Add emotion markers
          },
        ),
      ),
    );
  }
}