import 'package:equatable/equatable.dart';

abstract class scheduleState extends Equatable {
  const scheduleState();

  @override
  List<Object?> get props => [];
}

class ScheduleInitial extends scheduleState {}

class ScheduleLoading extends scheduleState {}

class ScheduleLoaded extends scheduleState {
  final Map<DateTime, List<String>> schedules;
  final DateTime selectedDay;

  const ScheduleLoaded(this.schedules, this.selectedDay);

  @override
  List<Object?> get props => [schedules, selectedDay];
}

class ScheduleError extends scheduleState {
  final String message;

  const ScheduleError(this.message);

  @override
  List<Object?> get props => [message];
}
