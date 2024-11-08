import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SetScheduleEvent extends Equatable {
  const SetScheduleEvent();

  @override
  List<Object> get props => [];
}

class SetSchedule extends SetScheduleEvent {
  final String taskName;
  final int categoryID;
  final DateTime startDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final bool isRepeat;
  final int notificationDuration;
  final String notificationUnit;
  final String note;
  final String userID;

  const SetSchedule({
    required this.taskName,
    required this.categoryID,
    required this.startDate,
    required this.startTime,
    required this.endTime,
    required this.isRepeat,
    required this.notificationDuration,
    required this.notificationUnit,
    required this.note,
    required this.userID,
  });

  @override
  List<Object> get props =>
      [
        taskName,
        categoryID,
        startDate,
        startTime,
        endTime,
        isRepeat,
        notificationDuration,
        notificationUnit,
        note,
        userID
      ];
}
