import 'package:flutter/material.dart';
import 'package:schedule_repository/src/entities/entities.dart';

class Schedule {
  int scheduleID;
  String taskName;
  int categoryID;
  DateTime startDate;
  TimeOfDay startTime;
  TimeOfDay endTime;
  bool isRepeat;
  int notificationDuration;
  String notificationUnit;
  String note;
  String userID;

  Schedule({
    required this.scheduleID,
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

  static final empty = Schedule(
    scheduleID: 0000,
    taskName: '',
    categoryID: 0,
    startDate: DateTime(1970, 1, 1),
    startTime: const TimeOfDay(hour: 0, minute: 0),
    endTime: const TimeOfDay(hour: 0, minute: 0),
    isRepeat: false,
    notificationDuration: 0,
    notificationUnit: '',
    note: '',
    userID: '',
  );

  ScheduleEntity toEntity() {
    return ScheduleEntity(
      scheduleID: scheduleID,
      taskName: taskName,
      categoryID: categoryID,
      startDate: startDate,
      startTime: startTime,
      endTime: endTime,
      isRepeat: isRepeat,
      notificationDuration: notificationDuration,
      notificationUnit: notificationUnit,
      note: note,
      userID: userID,
    );
  }

  static Schedule fromEntity(ScheduleEntity entity) {
    return Schedule(
      scheduleID: entity.scheduleID,
      taskName: entity.taskName,
      categoryID: entity.categoryID,
      startDate: entity.startDate,
      startTime: entity.startTime,
      endTime: entity.endTime,
      isRepeat: entity.isRepeat,
      notificationDuration: entity.notificationDuration,
      notificationUnit: entity.notificationUnit,
      note: entity.note,
      userID: entity.userID,
    );
  }

  @override
  String toString() {
    return 'Schedule: $scheduleID, $taskName, $categoryID, $startDate, $startTime, $endTime, $isRepeat, $notificationDuration, $notificationUnit, $note, $userID';
  }
}
