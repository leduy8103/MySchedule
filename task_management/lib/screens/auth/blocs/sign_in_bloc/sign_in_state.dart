part of 'sign_in_bloc.dart';

@immutable
sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInFailure extends SignInState {}

final class SignInProcess extends SignInState {}

final class SignInSuccess extends SignInState {}
