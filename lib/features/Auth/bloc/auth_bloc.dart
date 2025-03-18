import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/repositories/auth_repository.dart';
import '../data/models/models.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> with ChangeNotifier {
  final AuthRepository _authRepository;
  late final StreamSubscription<firebase_auth.User?> _userSubscription;

  AuthBloc({required AuthRepository authRepository})
    : _authRepository = authRepository,
      super(AuthInitial()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInRequested>(_onSignInRequested);
    on<ResetPasswordRequested>(_onResetPasswordRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<AuthenticationUserChanged>(_onAuthenticationUserChanged);

    _userSubscription = _authRepository.user.listen((firebaseUser) async {
      add(AuthenticationUserChanged(firebaseUser));
    });
  }

  FutureOr<void> _onAuthenticationUserChanged(
    AuthenticationUserChanged event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInitial());
    notifyListeners();
    await Future.delayed(Duration(seconds: 2));
    try {
      final user = await _authRepository.toUserModel(event.user);
      final status = user.isNotEmpty ? Authenticated(user) : Unauthenticated();
      emit(status);
      notifyListeners();
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.signUp(
        email: event.email,
        password: event.password,
        name: event.name,
        userType: event.userType,
      );
      final user = await _authRepository.getCurrentUser();
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.signIn(
        email: event.email,
        password: event.password,
      );
      final user = await _authRepository.getCurrentUser();
      emit(Authenticated(user));
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onResetPasswordRequested(
    ResetPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.resetPassword(email: event.email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
    SignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await _authRepository.signOut();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
