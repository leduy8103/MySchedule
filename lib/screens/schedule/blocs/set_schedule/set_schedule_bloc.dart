import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:schedule_repository/schedule_repository.dart'; // Import repository
import 'set_schedule_event.dart'; // Import event
import 'set_schedule_state.dart'; // Import state

class SetScheduleBloc extends Bloc<SetScheduleEvent, SetScheduleState> {
  final ScheduleRepository scheduleRepository;

  SetScheduleBloc({required this.scheduleRepository})
      : super(SetScheduleInitial()) {
    on<SetSchedule>((event, emit) async {
      emit(SetScheduleLoading()); // Phát ra trạng thái Loading

      try {
        // Lưu lịch vào Firestore
        await scheduleRepository.setSchedule(
          taskName: event.taskName,
          startDate: event.startDate,
          endDate: event.endDate,
          startTime: event.startTime,
          endTime: event.endTime,
          status: event.status,
          isRepeat: event.isRepeat,
        );

        emit(SetScheduleSuccess()); // Phát ra trạng thái Success
      } catch (error) {
        emit(
            SetScheduleFailure(error.toString())); // Phát ra trạng thái Failure
      }
    });
  }
}
