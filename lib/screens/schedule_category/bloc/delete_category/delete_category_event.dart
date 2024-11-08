part of 'delete_category_bloc.dart';

sealed class DeleteCategoryEvent extends Equatable {
  const DeleteCategoryEvent();

  @override
  List<Object> get props => [];
}

class DeleteCategoryRequest extends DeleteCategoryEvent {
  final int categoryID;

  const DeleteCategoryRequest(this.categoryID);

  @override
  List<Object> get props => [categoryID];
}
