import 'dart:async';

import 'package:assignment_6/data_layer/home_data_layer.dart';
import 'package:assignment_6/services/database_service.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final locator = GetIt.I.get<HomeData>();
  AuthBloc() : super(AuthInitial()) {
    on<SignupEvent>(signup);
    on<SigninEvent>(signin);
    on<SignoutEvent>(signout);
    on<ResendConfirmationEmail>(resendConfirmEmail);
    on<SendOtpEvent>(sendOtp);
    on<ConfirmOtpEvent>(confirmOtp);
    on<ChangePasswordEvent>(changePassword);
  }

  FutureOr<void> signup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    if (event.email.trim().isNotEmpty && event.password.trim().isNotEmpty) {
      try {
        await DBService().signup(email: event.email, password: event.password);
        emit(SignedUpState(
            msg:
                "Your account has been created, please confirm your email before signing in."));
        locator.currentEmailAdress = event.email;
      } on AuthException catch (e) {
        print(e);
        emit(ErrorState(msg: "Email/Password Invalid"));
      } on Exception catch (e) {
        print(e);
        emit(ErrorState(
            msg:
                "There's an error with our service, please try again later..."));
      }
    } else {
      emit(ErrorState(msg: "Please fill all fields"));
    }
  }

  FutureOr<void> signin(SigninEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());
    if (event.email.trim().isNotEmpty && event.password.trim().isNotEmpty) {
      try {
        await DBService().signin(email: event.email, password: event.password);
        emit(SignedInState(msg: "Succesfully signed in"));
      } on AuthException catch (e) {
        print(e);
        emit(ErrorState(
            msg: "Email/Password Invalid (Make sure to confirm your email)"));
      } on Exception catch (e) {
        print(e);
        emit(ErrorState(
            msg:
                "There's an error with our service, please try again later..."));
      }
    } else {
      emit(ErrorState(msg: "Please fill all fields"));
    }
  }

  FutureOr<void> signout(SignoutEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());

    try {
      await DBService().signout();
      emit(SignedOutState(msg: "Sucessfuly signed out, see you soon!"));
    } catch (e) {
      print(e);
      emit(ErrorState(
          msg: "There's an error with our service, please try again later..."));
    }
  }

  FutureOr<void> resendConfirmEmail(
      ResendConfirmationEmail event, Emitter<AuthState> emit) async {
    emit(LoadingState());

    try {
      await DBService().resend(email: event.email);
      emit(
          EmailResentState(msg: "Confirmation email resent to ${event.email}"));
    } catch (e) {
      emit(ErrorState(msg: "Confirmation email could not be sent..."));
    }
  }

  FutureOr<void> sendOtp(
      SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(LoadingState());

    if (event.email.trim().isNotEmpty) {
      try {
        await DBService().sendOtp(email: event.email, );
        emit(OtpSentState(
            msg:
                "An email has been sent with an otp to reset your password, check your inbox"));
                locator.currentEmailAdress = event.email;
      }on AuthException catch (e) {
        print(e);
        emit(ErrorState(msg: "Email is invalid"));
      } on Exception catch (e) {
        print(e);
        emit(ErrorState(msg: "There's an issue with our servers, please try again later"));
      }
    } else {
      emit(ErrorState(msg: "Please input email"));
    }
  }

  FutureOr<void> confirmOtp(ConfirmOtpEvent event, Emitter<AuthState> emit) async{
    emit(LoadingState());

    if(event.otpToken.trim().isNotEmpty){
      try {
        await DBService().verifyOtp(email: event.email, otpToken: event.otpToken);
        emit(OtpConfirmedState(msg: "OTP Confirmed, please enter your new password"));
      } on AuthException catch (e) {
        print(e);
        emit(ErrorState(msg: "Invalid OTP token, please try again"));
      } on Exception catch(e) {
        print(e);
        emit(ErrorState(msg: "There's an issue with our servers, please try again later"));
      }
    }else {
      emit(ErrorState(msg: "Please enter OTP"));
    }
  }

  FutureOr<void> changePassword(ChangePasswordEvent event, Emitter<AuthState> emit) async{
    emit(LoadingState());
    if(event.password.trim().isNotEmpty && event.password.length >= 6){
      try {
      await DBService().changePassword(password: event.password);
      emit(PasswordChangedState(msg: "Password Sucessfuly changed"));
      await DBService().signout();
    } on AuthException catch (e) {
      print(e);
      emit(ErrorState(msg: "You're not authorized to change your password"));
    } on Exception catch(e) {
      print(e);
        emit(ErrorState(msg: "There's an issue with our servers, please try again later"));
    }
    }else {
      emit(ErrorState(msg: "Please input your password (6 characters or more)"));
    }
    
  }
}
