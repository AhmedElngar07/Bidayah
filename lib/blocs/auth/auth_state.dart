import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String? userName;

  AuthAuthenticated({this.userName});

  @override
  List<Object?> get props => [userName];
}

class AuthUnauthenticated extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure({required this.message});

  @override
  List<Object?> get props => [message];
}