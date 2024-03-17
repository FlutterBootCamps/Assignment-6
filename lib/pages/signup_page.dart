import 'package:assignment_6/bloc/auth_bloc.dart';
import 'package:assignment_6/helpers/extensions/screen_helper.dart';
import 'package:assignment_6/pages/email_confirm_page.dart';
import 'package:assignment_6/pages/login_page.dart';
import 'package:assignment_6/utils/colors.dart';
import 'package:assignment_6/utils/spacing.dart';
import 'package:assignment_6/widgets/simple_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: blackColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is ErrorState){
                context.showErrorSnackBar(context, state.msg);
              }else if (state is SignedUpState){
                context.showSuccessSnackBar(context, state.msg);
                context.push(context, const EmailConfrimPage(), true);
              }else if (state is SignedOutState){
                context.showSuccessSnackBar(context, state.msg);
              }
            },
            builder: (context, state) {
              if (state is LoadingState){
                return const Center(child: CircularProgressIndicator(color: whiteColor,),);
              }else{
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Shhhh",
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: 40,
                        fontWeight: FontWeight.w600),
                  ),
                  const Text(
                    "Your sleep management helper",
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  height32,
                  const Text(
                    "Sign up",
                    style: TextStyle(
                        color: whiteColor,
                        fontSize: 24,
                        fontWeight: FontWeight.w600),
                  ),
                  height16,
                  SimpleTextField(
                    hintText: "Enter your email",
                    labelText: "Email",
                    controller: emailController,
                  ),
                  height16,
                  SimpleTextField(
                    isObscured: true,
                    labelText: "Password",
                    hintText: "Enter your password",
                    controller: passwordController,
                  ),
                  height16,
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(whiteColor)),
                      onPressed: () {
                        context.read<AuthBloc>().add(SignupEvent(email: emailController.text, password: passwordController.text));
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )),
                  height32,
                  Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                          onPressed: () {
                            context.push(context, LoginPage(), false);
                          },
                          child: RichText(
                            text: const TextSpan(
                                text: "Already have an account? ",
                                children: [
                                  TextSpan(
                                      text: "Log in",
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          decorationColor: whiteColor))
                                ]),
                          ))),
                ],
              );
            }
            }
          ),
        ),
      ),
    );
  }
}
