// lib/blocs/auth/auth_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bidayah/services/auth_service.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService _authService;

  AuthBloc({required AuthService authService})
      : _authService = authService,
        super(AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthSignUpRequested>(_onSignUpRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      
      await _authService.login(
        email: event.email,
        password: event.password,
        context: event.context,
      );
      
    
      emit(AuthAuthenticated());
    } catch (e) {
      emit(AuthFailure(message: "An error occurred: ${e.toString()}"));
    }
  }

  Future<void> _onSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final userCredential = await _authService.signup(
        fullName: event.fullName,
        email: event.email,
        password: event.password,
      );

      if (userCredential != null) {
        emit(AuthAuthenticated(userName: event.fullName));
      } else {
        emit(AuthFailure(message: "Registration failed. Please try again."));
      }
    } catch (e) {
      emit(AuthFailure(message: "An error occurred: ${e.toString()}"));
    }
  }

  Future<void> _onLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    // Implement logout logic if needed
    emit(AuthUnauthenticated());
  }
}