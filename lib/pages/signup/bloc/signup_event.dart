part of 'signup_bloc.dart';

@immutable
sealed class SignUpEvent {}

class CreateAccountEvent extends SignUpEvent {
  final String email;
  final String password;
  CreateAccountEvent({required this.email, required this.password});
}
