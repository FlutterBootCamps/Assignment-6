import 'package:assignment_6/bloc/auth_bloc.dart';
import 'package:assignment_6/helpers/extensions/screen_helper.dart';
import 'package:assignment_6/pages/forget_password_page.dart';
import 'package:assignment_6/pages/home_page.dart';
import 'package:assignment_6/pages/signup_page.dart';
import 'package:assignment_6/utils/colors.dart';
import 'package:assignment_6/utils/spacing.dart';
import 'package:assignment_6/widgets/simple_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is ErrorState){
                context.showErrorSnackBar(context, state.msg);
              }else if (state is SignedInState){
                context.showSuccessSnackBar(context, state.msg);
                context.push(context, const HomePage(), false);
              }else if (state is SignedOutState){
                context.showSuccessSnackBar(context, state.msg);
              }
            },
            builder: (context, state) {
              if (state is LoadingState){
                return const Center(child: CircularProgressIndicator(color: blackColor,),);
              }else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Welcome back",
                    style: TextStyle(
                        color: blackColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    "Ready to snore away?",
                    style: TextStyle(
                        color: blackColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  height32,
                  const Text(
                    "Login",
                    style: TextStyle(
                        color: blackColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  height16,
                  SimpleTextField(
                    hintLabelColor: whiteColor,
                    fillColor: blackColor,
                    textStyle: const TextStyle(color: whiteColor),
                    hintText: "Enter your email",
                    labelText: "Email",
                    controller: emailController,
                  ),
                  height16,
                  SimpleTextField(
                    isObscured: true,
                    hintLabelColor: whiteColor,
                    fillColor: blackColor,
                    textStyle: const TextStyle(color: whiteColor),
                    labelText: "Password",
                    hintText: "Enter your password",
                    controller: passwordController,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          onPressed: () {
                            context.push(context, ForgetPasswordPage(), true);
                          },
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(color: blackColor),
                          ))),
                  height16,
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(blackColor)),
                      onPressed: () {
                        context.read<AuthBloc>().add(SigninEvent(email: emailController.text, password: passwordController.text));
                      },
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )),
                  height32,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          context.push(context, SignUpPage(), false);
                        },
                        child: RichText(
                          text: const TextSpan(
                              text: "Don't have an account yet? ",
                              children: [
                                TextSpan(
                                  text: "Signup",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationColor: blackColor),
                                ),
                              ],
                              style: TextStyle(color: blackColor)),
                        ),
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
