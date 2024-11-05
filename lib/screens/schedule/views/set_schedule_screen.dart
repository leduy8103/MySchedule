import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/screens/schedule/blocs/set_schedule/set_schedule_bloc.dart';
import 'package:task_management/screens/schedule/blocs/set_schedule/set_schedule_event.dart';
import 'package:task_management/screens/schedule/blocs/set_schedule/set_schedule_state.dart';
import 'package:intl/intl.dart';

class SetScheduleScreen extends StatefulWidget {
  const SetScheduleScreen({super.key});

  @override
  _SetScheduleScreenState createState() => _SetScheduleScreenState();
}

class _SetScheduleScreenState extends State<SetScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  String taskName = '';
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  String status = 'Pending';
  bool isRepeat = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Schedule'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Create a New Schedule',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    _buildTaskNameField(),
                    const SizedBox(height: 16.0),
                    _buildDateTimePicker('Start Date', true),
                    const SizedBox(height: 16.0),
                    _buildDateTimePicker('End Date', false),
                    const SizedBox(height: 16.0),
                    _buildTimePicker('Start Time', true),
                    const SizedBox(height: 16.0),
                    _buildTimePicker('End Time', false),
                    const SizedBox(height: 16.0),
                    _buildRepeatSwitch(),
                    const SizedBox(height: 16.0),
                    _buildSaveButton(),
                    BlocListener<SetScheduleBloc, SetScheduleState>(
                      listener: (context, state) {
                        if (state is SetScheduleSuccess) {
                          Navigator.pop(context); // Quay lại trang trước
                        } else if (state is SetScheduleFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Failed to set schedule: ${state.error}'),
                            ),
                          );
                        }
                      },
                      child: Container(), // Placeholder for listener
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Task Name',
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter task name';
        }
        return null;
      },
      onSaved: (value) {
        taskName = value!;
      },
    );
  }

  Widget _buildDateTimePicker(String label, bool isStartDate) {
    return ListTile(
      title: Text(label, style: const TextStyle(fontSize: 18.0)),
      trailing: ElevatedButton(
        onPressed: () => _selectDate(context, isStartDate),
        child: Text(
          isStartDate
              ? DateFormat('dd/MM/yyyy').format(startDate)
              : DateFormat('dd/MM/yyyy').format(endDate),
        ),
      ),
    );
  }

  Widget _buildTimePicker(String label, bool isStartTime) {
    return ListTile(
      title: Text(label, style: const TextStyle(fontSize: 18.0)),
      trailing: ElevatedButton(
        onPressed: () => _selectTime(context, isStartTime),
        child: Text(
          isStartTime
              ? '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}'
              : '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}',
        ),
      ),
    );
  }

  Widget _buildRepeatSwitch() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Repeat this task?', style: TextStyle(fontSize: 18.0)),
        Switch(
          value: isRepeat,
          onChanged: (value) {
            setState(() {
              isRepeat = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _saveSchedule,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
      ),
      child: const Text(
        'Save Schedule',
        style: TextStyle(fontSize: 18.0),
        selectionColor: Colors.pinkAccent,
      ),
    );
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? startDate : endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != (isStartDate ? startDate : endDate)) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? startTime : endTime,
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  void _saveSchedule() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Phát sự kiện lưu lịch
      BlocProvider.of<SetScheduleBloc>(context).add(
        SetSchedule(
          taskName: taskName,
          startDate: startDate,
          endDate: endDate,
          startTime: startTime,
          endTime: endTime,
          status: status,
          isRepeat: isRepeat,
        ),
      );
    }
  }
}
