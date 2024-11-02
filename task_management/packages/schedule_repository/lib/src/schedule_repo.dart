import 'package:flutter/material.dart';
import 'package:schedule_repository/schedule_repository.dart';

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
