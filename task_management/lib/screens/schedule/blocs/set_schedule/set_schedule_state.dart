import 'package:equatable/equatable.dart';

abstract class SetScheduleState extends Equatable {
  const SetScheduleState();

  @override
  List<Object> get props => [];
}

class SetScheduleInitial extends SetScheduleState {}

class SetScheduleLoading extends SetScheduleState {}

class SetScheduleSuccess extends SetScheduleState {}

class SetScheduleFailure extends SetScheduleState {
  final String error;

  const SetScheduleFailure(this.error);

  @override
  List<Object> get props => [error];
}
