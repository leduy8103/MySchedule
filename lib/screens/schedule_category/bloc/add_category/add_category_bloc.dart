import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:schedule_category_repository/schedule_category_repository.dart';

part 'add_category_event.dart';
part 'add_category_state.dart';

class AddCategoryBloc extends Bloc<AddCategoryEvent, AddCategoryState> {
  final ScheduleCategoryRepo categoryRepo;

  AddCategoryBloc({required this.categoryRepo}) : super(AddCategoryInitial()) {
    on<SubmitNewCategory>(_onSubmitNewCategory);
  }

  Future<void> _onSubmitNewCategory(
      SubmitNewCategory event, Emitter<AddCategoryState> emit) async {
    emit(AddCategoryLoading());

    try {
      // Thực hiện thêm category vào repository với categoryID
      await categoryRepo.createNew(
        categoryName: event.categoryName,
        color: event.color,
        userID: event.userID,
      );

      emit(AddCategorySuccess());
    } catch (error) {
      emit(AddCategoryFailure(error.toString()));
    }
  }
}
