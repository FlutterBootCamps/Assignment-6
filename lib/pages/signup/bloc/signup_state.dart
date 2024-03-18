part of 'signup_bloc.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class LoadingState extends SignUpState {}

final class SuccessState extends SignUpState {}

final class ErrorState extends SignUpState {}