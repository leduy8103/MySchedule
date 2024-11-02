part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {}

class SignUpRequired extends SignUpEvent {
  final MyUser user;
  final String password;

  SignUpRequired(this.user, this.password);

  @override
  List<Object> get props => [user, password];
}
