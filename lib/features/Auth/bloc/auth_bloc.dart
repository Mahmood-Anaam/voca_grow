import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository = AuthRepository();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  StreamSubscription<User?>? _authSubscription;

  AuthBloc() : super(AuthLoading()) {
    // Listen to auth state changes
    _authSubscription = _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        // User is signed in
        add(UserLoggedIn(user));
      } else {
        // User is signed out
        add(UserLoggedOut());
      }
    });

    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
    on<ResetPasswordEvent>(_onResetPassword);
    on<SignOutEvent>(_onSignOut);
    on<UserLoggedIn>(_onUserLoggedIn);
    on<UserLoggedOut>(_onUserLoggedOut);
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signIn(event.email, event.password);
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure('User not found'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await authRepository.signUp(
        event.email,
        event.password,
        event.name,
      );
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure('Failed to sign up'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await authRepository.resetPassword(event.email);
      emit(AuthSuccess(null));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authRepository.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onUserLoggedIn(
    UserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = authRepository.getCurrentUser();
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure('User not found'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onUserLoggedOut(
    UserLoggedOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInitial());
  }

  @override
  Future<void> close() {
    _authSubscription
        ?.cancel(); // Cancel the subscription when the bloc is closed
    return super.close();
  }
}
