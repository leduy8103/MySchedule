part of 'get_categories_bloc.dart';

sealed class GetCategoriesState extends Equatable {
  const GetCategoriesState();

  @override
  List<Object> get props => [];
}

final class GetCategoriesInitial extends GetCategoriesState {}

class GetCategoriesInProgress extends GetCategoriesState {}

class GetCategoriesSuccess extends GetCategoriesState {
  final List<Map<String, dynamic>> categories;

  GetCategoriesSuccess(this.categories);

  @override
  List<Object> get props => [categories];
}

class GetCategoriesFailure extends GetCategoriesState {
  final String error;

  GetCategoriesFailure(this.error);

  @override
  List<Object> get props => [error];
}
