import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/screens/schedule/blocs/set_schedule/set_schedule_bloc.dart';
import 'package:task_management/screens/schedule/blocs/set_schedule/set_schedule_event.dart';
import 'package:task_management/screens/schedule/blocs/set_schedule/set_schedule_state.dart';
import 'package:intl/intl.dart';
import 'package:task_management/screens/schedule_category/bloc/get_categories/get_categories_bloc.dart';
import 'package:user_repository/user_repository.dart';

class SetScheduleScreen extends StatefulWidget {
  const SetScheduleScreen({super.key});

  @override
  _SetScheduleScreenState createState() => _SetScheduleScreenState();
}

class _SetScheduleScreenState extends State<SetScheduleScreen> {
  final _formKey = GlobalKey<FormState>();
  String taskName = '';
  DateTime startDate = DateTime.now();
  TimeOfDay startTime = TimeOfDay.now();
  TimeOfDay endTime = TimeOfDay.now();
  String status = 'Pending';
  bool isRepeat = false;
  String? userID;
  int? selectedCategoryID;
  int notificationDuration = 0;
  String notificationUnit = 'minutes';
  String note = '';

  @override
  void initState() {
    super.initState();
    _fetchUID();
    _fetchCategories();
  }

  Future<void> _fetchUID() async {
    final userRepository = RepositoryProvider.of<UserRepository>(context);
    userID = await userRepository.getCurrentUID();
  }

  void _fetchCategories() {
    BlocProvider.of<GetCategoriesBloc>(context).add(GetCategoriesRequested());
  }

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
                    _buildCategoryDropdown(),
                    const SizedBox(height: 16.0),
                    _buildDateTimePicker('Start Date'),
                    const SizedBox(height: 16.0),
                    _buildTimePicker('Start Time', true),
                    const SizedBox(height: 16.0),
                    _buildTimePicker('End Time', false),
                    const SizedBox(height: 16.0),
                    _buildNotificationPicker(),
                    const SizedBox(height: 16.0),
                    _buildRepeatSwitch(),
                    const SizedBox(height: 16.0),
                    _buildNoteField(), // Thêm trường Note
                    const SizedBox(height: 16.0),
                    _buildSaveButton(),
                    BlocListener<SetScheduleBloc, SetScheduleState>(
                      listener: (context, state) {
                        if (state is SetScheduleSuccess) {
                          Navigator.pop(context);
                        } else if (state is SetScheduleFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Failed to set schedule: ${state.error}'),
                            ),
                          );
                        }
                      },
                      child: Container(),
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

  Widget _buildNoteField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Note',
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      maxLines: 4,
      maxLength: 150, // Giới hạn tối đa 150 từ
      onChanged: (value) {
        setState(() {
          note = value;
        });
      },
      validator: (value) {
        if (value != null && value.split(' ').length > 150) {
          return 'Note cannot exceed 150 words';
        }
        return null;
      },
    );
  }

  Widget _buildCategoryDropdown() {
    return BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
      builder: (context, state) {
        if (state is GetCategoriesInProgress) {
          return const CircularProgressIndicator();
        } else if (state is GetCategoriesSuccess) {
          final categories = state.categories;
          return DropdownButtonFormField<int>(
            decoration: const InputDecoration(
              labelText: 'Category',
              border: OutlineInputBorder(),
            ),
            items: categories.map((category) {
              return DropdownMenuItem<int>(
                value: category['categoryID'],
                child: Row(
                  children: [
                    Icon(Icons.circle, color: Color(category['color'])),
                    const SizedBox(width: 8.0),
                    Text(category['categoryName']),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCategoryID = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Please select a category';
              }
              return null;
            },
          );
        } else if (state is GetCategoriesFailure) {
          return Text('Error loading categories: ${state.error}');
        }
        return const Text('No categories available');
      },
    );
  }

  Widget _buildDateTimePicker(String label) {
    return ListTile(
      title: Text(label, style: const TextStyle(fontSize: 18.0)),
      trailing: ElevatedButton(
        onPressed: () => _selectDate(context),
        child: Text(DateFormat('dd/MM/yyyy').format(startDate)),
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

  Widget _buildNotificationPicker() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Notify Before',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              notificationDuration = int.tryParse(value) ?? 0;
            },
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          flex: 3,
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Unit',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(value: 'minutes', child: Text('Minutes')),
              DropdownMenuItem(value: 'hours', child: Text('Hours')),
              DropdownMenuItem(value: 'days', child: Text('Days')),
              DropdownMenuItem(value: 'weeks', child: Text('Weeks')),
              DropdownMenuItem(value: 'months', child: Text('Months')),
            ],
            onChanged: (value) {
              setState(() {
                notificationUnit = value!;
              });
            },
          ),
        ),
      ],
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
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != startDate) {
      setState(() {
        startDate = picked;
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
      final validCategoryID =
          selectedCategoryID ?? 0; // Cung cấp giá trị mặc định là 0
      final validUserID =
          userID ?? ''; // Cung cấp giá trị mặc định là chuỗi rỗng
      BlocProvider.of<SetScheduleBloc>(context).add(
        SetSchedule(
          taskName: taskName,
          startDate: startDate,
          startTime: startTime,
          endTime: endTime,
          isRepeat: isRepeat,
          categoryID: validCategoryID,
          notificationDuration: notificationDuration,
          notificationUnit: notificationUnit,
          note: note,
          userID: validUserID,
        ),
      );
    }
  }
}
