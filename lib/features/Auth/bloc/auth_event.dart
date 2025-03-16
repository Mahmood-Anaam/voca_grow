part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;
  
  const SignInEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const SignUpEvent(this.email, this.password, this.name);

  @override
  List<Object> get props => [email, password, name];
}

class ResetPasswordEvent extends AuthEvent {
  final String email;

  const ResetPasswordEvent(this.email);

  @override
  List<Object> get props => [email];
}

class SignOutEvent extends AuthEvent {}

class UserLoggedIn extends AuthEvent {
  final User user;

  const UserLoggedIn(this.user);

  @override
  List<Object> get props => [user];
}

class UserLoggedOut extends AuthEvent {}