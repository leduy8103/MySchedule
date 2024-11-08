import 'package:flutter/material.dart';

abstract class ScheduleRepository {
  Future<void> setSchedule({
    required String taskName,
    required int categoryID,
    required DateTime startDate,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required bool isRepeat,
    required int notificationDuration,
    required String notificationUnit,
    required String note,
    required String userID,
  });
}
