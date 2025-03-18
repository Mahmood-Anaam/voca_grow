part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final UserType userType;

  const SignUpRequested({
    required this.email,
    required this.password,
    required this.name,
    required this.userType,
  });

  @override
  List<Object> get props => [email, password, name, userType];
}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  const SignInRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class ResetPasswordRequested extends AuthEvent {
  final String email;

  const ResetPasswordRequested({required this.email});

  @override
  List<Object> get props => [email];
}

class SignOutRequested extends AuthEvent {}


class AuthenticationUserChanged extends AuthEvent {
  final firebase_auth.User? user;

  const AuthenticationUserChanged(this.user);

  @override
  List<Object> get props => [user??''];
}


