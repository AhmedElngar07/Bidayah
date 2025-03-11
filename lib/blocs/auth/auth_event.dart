import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;
  final BuildContext context;

  AuthLoginRequested({
    required this.email,
    required this.password,
    required this.context,
  });

  @override
  List<Object?> get props => [email, password, context];
}

class AuthSignUpRequested extends AuthEvent {
  final String fullName;
  final String email;
  final String password;

  AuthSignUpRequested({
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [fullName, email, password];
}

class AuthLogoutRequested extends AuthEvent {}