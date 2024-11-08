import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:schedule_repository/schedule_repository.dart';

class FirebaseScheduleRepo implements ScheduleRepository {
  final scheduleCollection = FirebaseFirestore.instance.collection('schedules');

  Future<int> _getNextScheduleID() async {
    final counterRef = FirebaseFirestore.instance
        .collection('counters')
        .doc('scheduleCounter');
    return FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(counterRef);
      final currentID = snapshot.exists ? snapshot['lastScheduleID'] as int : 0;
      final newID = currentID + 1;

      // Update the counter with the new ID
      transaction.set(
          counterRef, {'lastScheduleID': newID}, SetOptions(merge: true));
      return newID;
    });
  }

  @override
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
      required String userID
  }) async {
    try {
      final scheduleID = await _getNextScheduleID();

      await scheduleCollection.doc(scheduleID.toString()).set({
        'scheduleID': scheduleID,
        'taskName': taskName,
        'categoryID': categoryID,
        'startDate':
            startDate.toIso8601String(), // Chuyển đổi DateTime thành String
        'startTime':
            '${startTime.hour}:${startTime.minute}', // Chuyển đổi TimeOfDay thành String
        'endTime':
            '${endTime.hour}:${endTime.minute}', // Chuyển đổi TimeOfDay thành String
        'isRepeat': isRepeat,
        'notificationDuration': notificationDuration,
        'notificationUnit': notificationUnit,
        'note': note,
        'userID': userID,
      });
    } catch (e) {
      throw Exception('Failed to set schedule: $e');
    }
  }
}
