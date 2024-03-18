import 'dart:async';
import 'dart:io';

import 'package:app_github_connection/data/service/database_auth/auth.dart';
import 'package:app_github_connection/pages/signin/bloc/signin_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<CreateAccountEvent>(createAccount);
  }

  FutureOr<void> createAccount(
      CreateAccountEvent event, Emitter<SignUpState> emit) async {
    try {
      emit(LoadingState());
      await DBService().SignUp(email: event.email, password: event.password);
      emit(SuccessState());
    } catch (error) {
      emit(ErrorState());
    }
  }
}
