import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SetScheduleEvent extends Equatable {
  const SetScheduleEvent();

  @override
  List<Object> get props => [];
}

class SetSchedule extends SetScheduleEvent {
  final String taskName;
  final DateTime startDate;
  final DateTime endDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String status;
  final bool isRepeat;

  const SetSchedule({
    required this.taskName,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.isRepeat,
  });

  @override
  List<Object> get props =>
      [taskName, startDate, endDate, startTime, endTime, status, isRepeat];
}
