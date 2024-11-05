import 'package:flutter/material.dart';

abstract class ScheduleRepository {
  Future<void> setSchedule({
    required String taskName,
    required DateTime startDate,
    required DateTime endDate,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required String status,
    required bool isRepeat,
  });
}
