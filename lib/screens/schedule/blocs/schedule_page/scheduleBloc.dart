import 'package:bloc/bloc.dart';
import 'scheduleEvent.dart';
import 'scheduleState.dart';

class scheduleBloc extends Bloc<scheduleEvent, scheduleState> {
  Map<DateTime, List<String>> daySchedules = {
    DateTime(2024, 10, 21): [
      'Meeting at 08:00',
      'Team Sync at 10:00',
      'Lunch at 12:00'
    ],
    DateTime(2024, 10, 22): ['Project deadline at 16:00'],
  };

  scheduleBloc() : super(ScheduleInitial()) {
    on<LoadSchedule>((event, emit) {
      emit(ScheduleLoading());
      try {
        // Assume fetching schedules
        emit(ScheduleLoaded(daySchedules, event.selectedDay));
      } catch (e) {
        emit(const ScheduleError("Failed to load schedules"));
      }
    });

    on<SelectDay>((event, emit) {
      if (state is ScheduleLoaded) {
        final currentState = state as ScheduleLoaded;
        emit(ScheduleLoaded(currentState.schedules, event.selectedDay));
      }
    });
  }
}
