part of 'add_category_bloc.dart';

sealed class AddCategoryState extends Equatable {
  const AddCategoryState();

  @override
  List<Object> get props => [];
}

final class AddCategoryInitial extends AddCategoryState {}

class AddCategoryLoading extends AddCategoryState {}

class AddCategorySuccess extends AddCategoryState {}

class AddCategoryFailure extends AddCategoryState {
  final String error;
  AddCategoryFailure(this.error);
}
