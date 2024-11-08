import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:schedule_category_repository/schedule_category_repository.dart';

part 'delete_category_event.dart';
part 'delete_category_state.dart';

class DeleteCategoryBloc
    extends Bloc<DeleteCategoryEvent, DeleteCategoryState> {
  final ScheduleCategoryRepo categoryRepo;
  DeleteCategoryBloc({required this.categoryRepo})
      : super(DeleteCategoryInitial()) {
    on<DeleteCategoryRequest>(_onDeleteCategoryRequest);
  }

  Future<void> _onDeleteCategoryRequest(
    DeleteCategoryRequest event,
    Emitter<DeleteCategoryState> emit,
  ) async {
    emit(DeleteCategoryInProgress()); // Cập nhật trạng thái là đang xoá

    try {
      // Thực hiện xoá category qua repository
      await categoryRepo.deleteCategory(event.categoryID);
      emit(DeleteCategorySuccess()); // Xử lý thành công
    } catch (e) {
      emit(DeleteCategoryFailure(e.toString())); // Xử lý thất bại
    }
  }
}
