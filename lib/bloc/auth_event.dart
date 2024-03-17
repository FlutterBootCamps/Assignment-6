part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SignupEvent extends AuthEvent {
  final String email;
  final String password;

  SignupEvent({required this.email, required this.password});
}

final class SigninEvent extends AuthEvent {
  final String email;
  final String password;

  SigninEvent({required this.email, required this.password});
}

final class SignoutEvent extends AuthEvent {
}

final class ResendConfirmationEmail extends AuthEvent {
  final String email;

  ResendConfirmationEmail({required this.email});
}

final class ResetPasswordEvent extends AuthEvent {
  final String email;

  ResetPasswordEvent({required this.email});
}