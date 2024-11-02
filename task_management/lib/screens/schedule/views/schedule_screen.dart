import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_repository/schedule_repository.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_management/screens/schedule/blocs/set_schedule/set_schedule_bloc.dart';
import 'package:task_management/screens/schedule/views/set_schedule_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // Sample schedules for demonstration
  Map<DateTime, List<String>> _daySchedules = {
    DateTime(2024, 10, 21): [
      'Meeting at 08:00',
      'Team Sync at 10:00',
      'Lunch at 12:00'
    ],
    DateTime(2024, 10, 22): ['Project deadline at 16:00'],
  };

  // Timer for double-click detection
  Timer? _tapTimer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple[50],
        title: Row(
          children: [
            Text(
              "Good Morning, Shuri",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
            Spacer(),
            CircleAvatar(
              backgroundImage: AssetImage('assets/avatar.png'),
              radius: 20,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            TableCalendar(
              firstDay: DateTime.utc(2020, 10, 16),
              lastDay: DateTime.utc(2030, 10, 16),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                _handleDaySelected(selectedDay);
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            SizedBox(height: 16),
            // Displaying the selected day's schedule
            Expanded(
              child: _selectedDay != null
                  ? _buildDaySchedule(_selectedDay)
                  : Center(child: Text('Select a day to view its schedule')),
            ),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => SetScheduleBloc(
                            scheduleRepository: FirebaseScheduleRepo()),
                        child: SetScheduleScreen(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Set schedule",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleDaySelected(DateTime selectedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = selectedDay;
    });
  }

  Widget _buildDaySchedule(DateTime selectedDay) {
    List<String>? schedules = _daySchedules[selectedDay];

    // Default hourly schedule format (08:00 to 18:00)
    final List<String> defaultTimes = [
      '08:00',
      '09:00',
      '10:00',
      '11:00',
      '12:00',
      '13:00',
      '14:00',
      '15:00',
      '16:00',
      '17:00',
      '18:00'
    ];

    return ListView.builder(
      itemCount: defaultTimes.length,
      itemBuilder: (context, index) {
        String timeSlot = defaultTimes[index];
        String? event = _findEventByTime(schedules, timeSlot);
        return ListTile(
          leading: Text(timeSlot,
              style: TextStyle(fontSize: 16, color: Colors.grey)),
          title: event.isNotEmpty
              ? Text(event, style: TextStyle(fontSize: 16, color: Colors.black))
              : Text('No event',
                  style: TextStyle(fontSize: 16, color: Colors.grey)),
          trailing:
              Icon(event.isNotEmpty ? Icons.event : Icons.circle_outlined),
        );
      },
    );
  }

  // Helper function to find event by time
  String _findEventByTime(List<String>? schedules, String time) {
    if (schedules == null || schedules.isEmpty) return '';

    for (String schedule in schedules) {
      if (schedule.contains(time)) {
        return schedule; // Return the matching event
      }
    }
    return ''; // Return empty string if no event found for this time
  }
}
