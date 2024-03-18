part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class LoadingState extends AuthState {}

final class SignedUpState extends AuthState {
  final String msg;

  SignedUpState({required this.msg});
}

final class EmailResentState extends AuthState {
  final String msg;

  EmailResentState({required this.msg});
}

final class OtpSentState extends AuthState {
  final String msg;

  OtpSentState({required this.msg});
}

final class OtpConfirmedState extends AuthState {
  final String msg;

  OtpConfirmedState({required this.msg});
}

final class PasswordChangedState extends AuthState {
  final String msg;

  PasswordChangedState({required this.msg});
}

final class SignedInState extends AuthState {
  final String msg;

  SignedInState({required this.msg});
}

final class SignedOutState extends AuthState {
  final String msg;

  SignedOutState({required this.msg});
}

final class ErrorState extends AuthState {
  final String msg;

  ErrorState({required this.msg});
}