import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  @override
  Widget build(BuildContext context) {

    DateTime _selectedDate = DateTime.now();

    bool isSameDay(DateTime date1, DateTime date2) {
      return date1.year == date2.year &&
          date1.month == date2.month &&
          date1.day == date2.day;
    }

    bool _isHoliday(DateTime day) {
      return day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TableCalendar(
              focusedDay: _selectedDate,
              firstDay: DateTime(DateTime.now().year),
              lastDay: DateTime(DateTime.now().year+2),
              calendarFormat: CalendarFormat.month,
              holidayPredicate: _isHoliday,
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDate = selectedDay;
                });
              },
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDate, day);
              },
            ),
          ],
        ),
      ),
    );
  }
}
