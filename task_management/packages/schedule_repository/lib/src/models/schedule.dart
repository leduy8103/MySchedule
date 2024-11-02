import 'package:flutter/material.dart';
import 'package:schedule_repository/src/entities/entities.dart';

class Schedule {
  int scheduleID;
  String taskName;
  DateTime startDate;
  DateTime endDate;
  TimeOfDay startTime;
  TimeOfDay endTime;
  String status;
  bool isRepeat;

  Schedule({
    required this.scheduleID,
    required this.taskName,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.isRepeat,
  });

  static final empty = Schedule(
    scheduleID: 0000,
    taskName: '',
    startDate: DateTime(1970, 1, 1),
    endDate: DateTime(1970, 1, 1),
    startTime: TimeOfDay(hour: 0, minute: 0),
    endTime: TimeOfDay(hour: 0, minute: 0),
    status: '',
    isRepeat: false,
  );

  ScheduleEntity toEntity() {
    return ScheduleEntity(
      scheduleID: scheduleID,
      taskName: taskName,
      startDate: startDate,
      endDate: endDate,
      startTime: startTime,
      endTime: endTime,
      status: status,
      isRepeat: isRepeat,
    );
  }

  static Schedule fromEntity(ScheduleEntity entity) {
    return Schedule(
      scheduleID: entity.scheduleID,
      taskName: entity.taskName,
      startDate: entity.startDate,
      endDate: entity.endDate,
      startTime: entity.startTime,
      endTime: entity.endTime,
      status: entity.status,
      isRepeat: entity.isRepeat,
    );
  }

  @override
  String toString() {
    return 'Schedule: $scheduleID, $taskName, $startDate, $endDate, $startTime, $endTime, $status, $isRepeat';
  }
}
