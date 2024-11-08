part of 'add_category_bloc.dart';

sealed class AddCategoryEvent extends Equatable {
  const AddCategoryEvent();

  @override
  List<Object> get props => [];
}

class SubmitNewCategory extends AddCategoryEvent {
  final String categoryName;
  final Color color;
  final String userID;

  SubmitNewCategory({
    required this.categoryName,
    required this.color,
    required this.userID,
  });
}
