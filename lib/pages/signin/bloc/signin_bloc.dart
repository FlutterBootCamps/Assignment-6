import 'dart:async';

import 'package:app_github_connection/data/service/database_auth/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitial()) {
    on<SignInEvent>((event, emit) {});
    on<AddSignInEvent>(signin);
    on<ResetPasswordEvent>(resetPassword);
  }

  FutureOr<void> signin(AddSignInEvent event, Emitter<SignInState> emit) async {
    try {
      emit(LoadingSignInState());
      await DBService().SignIn(email: event.email, password: event.password);
      emit(SuccessSignInState());
      } on AuthException catch (error) {
        emit(ErrorSignInState(massage: error.message));
      }

  }

  FutureOr<void> resetPassword(ResetPasswordEvent event, Emitter<SignInState> emit) async{
        try {
      emit(LoadingSignInState());
      await DBService().resetPassword(email: event.email);
      emit(SuccessSignInState());
      } on AuthException catch (error) {
        emit(ErrorSignInState(massage: error.message));
      }
  }
}
