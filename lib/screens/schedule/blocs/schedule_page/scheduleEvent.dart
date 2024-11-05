import 'package:equatable/equatable.dart';

abstract class scheduleEvent extends Equatable {
  const scheduleEvent();

  @override
  List<Object?> get props => [];
}

class LoadSchedule extends scheduleEvent {
  final DateTime selectedDay;

  const LoadSchedule(this.selectedDay);

  @override
  List<Object?> get props => [selectedDay];
}

class SelectDay extends scheduleEvent {
  final DateTime selectedDay;

  const SelectDay(this.selectedDay);

  @override
  List<Object?> get props => [selectedDay];
}
