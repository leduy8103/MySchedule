import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_repository/schedule_repository.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_management/screens/schedule/blocs/set_schedule/set_schedule_bloc.dart';
import 'package:task_management/screens/schedule/views/set_schedule_screen.dart';
import '../blocs/schedule_page/scheduleState.dart';
import '../blocs/schedule_page/scheduleEvent.dart';
import '../blocs/schedule_page/scheduleBloc.dart';

class scheduleScreen extends StatefulWidget {
  const scheduleScreen({super.key});

  @override
  State<scheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<scheduleScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
    // Load the initial schedule when the screen is initialized
    final DateTime now = DateTime.now();
    context.read<scheduleBloc>().add(LoadSchedule(now));
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.purple[50],
        title: const Row(
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
      body: BlocBuilder<scheduleBloc, scheduleState>(
        builder: (context, state) {
          if (state is ScheduleLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ScheduleLoaded) {
            return _buildScheduleContent(context, state);
          } else if (state is ScheduleError) {
            return Center(child: Text(state.message));
          }
          return Container(); // Default empty state
        },
      ),
    );
  }

  Widget _buildScheduleContent(BuildContext context, ScheduleLoaded state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          TableCalendar(
            firstDay: DateTime.utc(2020, 10, 16),
            lastDay: DateTime.utc(2030, 10, 16),
            focusedDay: state.selectedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(state.selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              context.read<scheduleBloc>().add(SelectDay(selectedDay));
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {},
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: state.schedules[state.selectedDay]?.length ?? 0,
              itemBuilder: (context, index) {
                final event = state.schedules[state.selectedDay]![index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(event),
                    leading: const Icon(Icons.event),
                  ),
                );
              },
            ),
          ),
          const Spacer(),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Handle Set Schedule button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Set schedule",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
