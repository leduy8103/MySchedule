// ignore_for_file: empty_constructor_bodies

import 'package:flutter/material.dart';

class ScheduleEntity {
  int scheduleID;
  String taskName;
  DateTime startDate;
  DateTime endDate;
  TimeOfDay startTime;
  TimeOfDay endTime;
  String status;
  bool isRepeat;

  ScheduleEntity({
    required this.scheduleID,
    required this.taskName,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.isRepeat,
  });

  Map<String, Object?> toDocument() {
    return {
      'scheduleID': scheduleID,
      'taskName': taskName,
      'startDate': startDate,
      'endDate': endDate,
      'startTime': startTime,
      'endTime': endTime,
      'status': status,
      'isRepeat': isRepeat,
    };
  }

  static ScheduleEntity fromDocument(Map<String, dynamic> doc) {
    return ScheduleEntity(
      scheduleID: doc['scheduleID'],
      taskName: doc['taskName'],
      startDate: doc['startDate'],
      endDate: doc['endDate'],
      startTime: doc['startTime'],
      endTime: doc['endTime'],
      status: doc['status'],
      isRepeat: doc['isRepeat'],
    );
  }
}
