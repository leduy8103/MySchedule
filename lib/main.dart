import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:async'; // Import the async library for Timer

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

// Main Home Page with Bottom Navigation Bar
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    SchedulePage(),  // Calendar Page
    SetReminderPage(),  // Set Reminder Page
    SettingsPage()  // Settings Page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],  // Show the selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Today Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// Calendar Page (Schedule Page)
class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // Sample schedules for demonstration
  Map<DateTime, List<String>> _daySchedules = {
    DateTime(2024, 10, 21): ['Meeting at 08:00', 'Team Sync at 10:00', 'Lunch at 12:00'],
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
            Expanded(  // Wrap the ListView in an Expanded widget to ensure proper rendering
              child: _selectedDay != null
                  ? _buildDaySchedule(_selectedDay)
                  : Center(child: Text('Select a day to view its schedule')),
            ),
            // SizedBox(height: 16),
            // ReminderCard(title: "Meeting"),
            // ReminderCard(title: "Test"),
            Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle Set Schedule button press
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

  // Display schedule for the selected day, even if there are no events
  Widget _buildDaySchedule(DateTime selectedDay) {
    List<String>? schedules = _daySchedules[selectedDay];

    // Default hourly schedule format (08:00 to 18:00)
    final List<String> defaultTimes = [
      '08:00', '09:00', '10:00', '11:00', '12:00', '13:00', '14:00', '15:00', '16:00', '17:00', '18:00'
    ];

    return ListView.builder(
      itemCount: defaultTimes.length,
      itemBuilder: (context, index) {
        String timeSlot = defaultTimes[index];
        String? event = _findEventByTime(schedules, timeSlot);
        return ListTile(
          leading: Text(timeSlot, style: TextStyle(fontSize: 16, color: Colors.grey)),
          title: event.isNotEmpty
              ? Text(event, style: TextStyle(fontSize: 16, color: Colors.black))
              : Text('No event', style: TextStyle(fontSize: 16, color: Colors.grey)),
          trailing: Icon(event.isNotEmpty ? Icons.event : Icons.circle_outlined),
        );
      },
    );
  }

  // Helper function to find event by time
  String _findEventByTime(List<String>? schedules, String time) {
    if (schedules == null || schedules.isEmpty) return '';

    for (String schedule in schedules) {
      if (schedule.contains(time)) {
        return schedule;  // Return the matching event
      }
    }
    return '';  // Return empty string if no event found for this time
  }
}

// Set Reminder Page
class SetReminderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Today Schedule"),
        backgroundColor: Colors.purple[50],
      ),
      body: Center(
        child: Text(
          'Today Schedule Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

// Settings Page
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.purple[50],
      ),
      body: Center(
        child: Text(
          'Settings Page',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

class ReminderCard extends StatelessWidget {
  final String title;

  ReminderCard({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.purpleAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(Icons.calendar_today, color: Colors.white),
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
