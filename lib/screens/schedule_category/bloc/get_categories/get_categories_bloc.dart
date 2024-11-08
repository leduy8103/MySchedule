import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:schedule_category_repository/schedule_category_repository.dart';

part 'get_categories_event.dart';
part 'get_categories_state.dart';

class GetCategoriesBloc extends Bloc<GetCategoriesEvent, GetCategoriesState> {
  final ScheduleCategoryRepo categoryRepo;
  GetCategoriesBloc({required this.categoryRepo})
      : super(GetCategoriesInitial()) {
    on<GetCategoriesRequested>(_onGetCategoriesRequested);
  }

  Future<void> _onGetCategoriesRequested(
    GetCategoriesRequested event,
    Emitter<GetCategoriesState> emit,
  ) async {
    emit(GetCategoriesInProgress());

    try {
      // Lấy danh sách categories từ repository
      final categoryStream = categoryRepo.getCategories();

      // Theo dõi stream và phát ra trạng thái GetCategoriesSuccess với dữ liệu mới
      await emit.forEach<List<Map<String, dynamic>>>(
        categoryStream,
        onData: (categories) => GetCategoriesSuccess(categories),
        onError: (error, _) => GetCategoriesFailure(error.toString()),
      );
    } catch (error) {
      emit(GetCategoriesFailure(error.toString()));
    }
  }
}
