import 'package:assignment_6/bloc/auth_bloc.dart';
import 'package:assignment_6/data_layer/home_data_layer.dart';
import 'package:assignment_6/helpers/extensions/screen_helper.dart';
import 'package:assignment_6/pages/new_password_page.dart';
import 'package:assignment_6/utils/colors.dart';
import 'package:assignment_6/utils/spacing.dart';
import 'package:assignment_6/widgets/simple_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

// ignore: must_be_immutable
class EnterOtpPage extends StatelessWidget {
  EnterOtpPage({super.key});

  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<HomeData>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: blackColor,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: whiteColor,
            )),
      ),
      backgroundColor: blackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is ErrorState) {
                context.showErrorSnackBar(context, state.msg);
              } else if (state is OtpConfirmedState) {
                context.showSuccessSnackBar(context, state.msg);
                context.push(context, NewPasswordPage(), false);
              }
            },
            builder:(context, state) {
              if (state is LoadingState){
                return const Center(child: CircularProgressIndicator(color: whiteColor,),);
              }else{
                return Column(
              children: [
                Image.asset("assets/images/repass.png"),
                height16,
                const Text(
                  "OTP Sent!",
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
                const Text(
                  "Check your email and enter your OTP",
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                height32,
                SimpleTextField(
                  textStyle: const TextStyle(color: blackColor),
                  hintText: "Enter your OTP",
                  labelText: "OTP",
                  controller: otpController,
                ),
                height32,
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(whiteColor)),
                    onPressed: () {
                      context.read<AuthBloc>().add(ConfirmOtpEvent(email: locator.currentEmailAdress, otpToken: otpController.text));
                    },
                    child: const Text(
                      "Confirm OTP",
                      style: TextStyle(
                          color: blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    )),
              ],
            );
              }
              
            },
            
          ),
        ),
      ),
    );
  }
}
