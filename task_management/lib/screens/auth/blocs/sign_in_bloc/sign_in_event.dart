part of 'sign_in_bloc.dart';

@immutable
sealed class SignInEvent {}

class SignInRequired extends SignInEvent {
  final String email;
  final String password;

  SignInRequired(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignOutRequired extends SignInEvent {}
