part of 'delete_category_bloc.dart';

sealed class DeleteCategoryState extends Equatable {
  const DeleteCategoryState();

  @override
  List<Object> get props => [];
}

final class DeleteCategoryInitial extends DeleteCategoryState {}

class DeleteCategoryInProgress extends DeleteCategoryState {}

class DeleteCategorySuccess extends DeleteCategoryState {}

class DeleteCategoryFailure extends DeleteCategoryState {
  final String error;

  const DeleteCategoryFailure(this.error);

  @override
  List<Object> get props => [error];
}
