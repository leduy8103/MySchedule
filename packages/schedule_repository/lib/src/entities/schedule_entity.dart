// ignore_for_file: empty_constructor_bodies

import 'package:flutter/material.dart';

class ScheduleEntity {
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

  ScheduleEntity({
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

  Map<String, Object?> toDocument() {
    return {
      'scheduleID': scheduleID,
      'taskName': taskName,
      'categoryID': categoryID,
      'startDate': startDate,
      'startTime': startTime,
      'endTime': endTime,
      'isRepeat': isRepeat,
      'notificationDuration': notificationDuration,
      'notificationUnit': notificationUnit,
      'note': note,
      'userID': userID,
    };
  }

  static ScheduleEntity fromDocument(Map<String, dynamic> doc) {
    return ScheduleEntity(
      scheduleID: doc['scheduleID'],
      taskName: doc['taskName'],
        categoryID: doc['categoryID'],
        startDate: doc['startDate'],
      startTime: doc['startTime'],
        endTime: doc['endTime'],
      isRepeat: doc['isRepeat'],
        notificationDuration: doc['notificationDuration'],
        notificationUnit: doc['notificationUnit'],
        note: doc['note'],
        userID: doc['userID']
    );
  }
}
