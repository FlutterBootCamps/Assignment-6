import 'package:assignment_6/bloc/auth_bloc.dart';
import 'package:assignment_6/data_layer/home_data_layer.dart';
import 'package:assignment_6/helpers/extensions/screen_helper.dart';
import 'package:assignment_6/pages/login_page.dart';
import 'package:assignment_6/utils/colors.dart';
import 'package:assignment_6/utils/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:timer_button/timer_button.dart';

class EmailConfrimPage extends StatelessWidget {
  const EmailConfrimPage({super.key});

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
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is ErrorState){
                context.showErrorSnackBar(context, state.msg);
              }else if (state is EmailResentState){
                context.showSuccessSnackBar(context, state.msg);
              }
            },
            child: Column(
              children: [
                Image.asset("assets/images/confirm.png"),
                height16,
                const Text(
                  "Confirmation Email Sent!",
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
                const Text(
                  "Click on the link sent to your email to confirm.",
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                height32,
                TimerButton(
                  label: "Resend",
                  onPressed: () {
                    context.read<AuthBloc>().add(ResendConfirmationEmail(email: locator.currentEmailAdress));
                  },
                  timeOutInSeconds: 60,
                  disabledColor: greyColor,
                  disabledTextStyle: const TextStyle(color: whiteColor),
                  activeTextStyle: const TextStyle(color: blackColor),
                  color: whiteColor,
                  buttonType: ButtonType.textButton,
                ),
                height32,
                ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(whiteColor)),
                      onPressed: () {
                        context.push(context, LoginPage(), false);
                      },
                      child: const Text(
                        "Done",
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
