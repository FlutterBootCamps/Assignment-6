import 'package:assignment_6/bloc/auth_bloc.dart';
import 'package:assignment_6/helpers/extensions/screen_helper.dart';
import 'package:assignment_6/utils/colors.dart';
import 'package:assignment_6/utils/spacing.dart';
import 'package:assignment_6/widgets/simple_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});

  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: blackColor,
            )),
        title: const Text("Reset Password",
            style: TextStyle(
                color: blackColor, fontSize: 20, fontWeight: FontWeight.w600)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is PasswordResetState){
                context.showSuccessSnackBar(context, state.msg);
              }
            },
            builder: (context, state) {
              if (state is LoadingState){
                return const Center(child: CircularProgressIndicator(color: blackColor,),);
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SimpleTextField(
                    hintLabelColor: whiteColor,
                    fillColor: blackColor,
                    textStyle: const TextStyle(color: whiteColor),
                    hintText: "Enter your email",
                    labelText: "Email",
                    controller: emailController,
                  ),
                  height32,
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(blackColor)),
                      onPressed: () {
                        context.read<AuthBloc>().add(
                            ResetPasswordEvent(email: emailController.text));
                      },
                      child: const Text(
                        "Reset Password",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
