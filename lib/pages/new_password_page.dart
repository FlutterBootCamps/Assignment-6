import 'package:assignment_6/bloc/auth_bloc.dart';
import 'package:assignment_6/helpers/extensions/screen_helper.dart';
import 'package:assignment_6/pages/login_page.dart';
import 'package:assignment_6/utils/colors.dart';
import 'package:assignment_6/utils/spacing.dart';
import 'package:assignment_6/widgets/simple_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class NewPasswordPage extends StatelessWidget {
  NewPasswordPage({super.key});

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: blackColor,
        leading: IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(SignoutEvent());
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
              } else if (state is PasswordChangedState) {
                context.showSuccessSnackBar(context, state.msg);
                context.push(context, LoginPage(), false);
              }
            },
            builder: (context, state) {
              if (state is LoadingState){
                return const Center(child: CircularProgressIndicator(color: whiteColor,),);
              }else{
              return Column(
              children: [
                Image.asset("assets/images/repass2.png"),
                height16,
                const Text(
                  "Reset your password",
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
                const Text(
                  "Enter your new password",
                  style: TextStyle(
                    color: whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                height32,
                SimpleTextField(
                  isObscured: true,
                  textStyle: const TextStyle(color: blackColor),
                  hintText: "New Password",
                  labelText: "New Password",
                  controller: passwordController,
                ),
                height32,
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(whiteColor)),
                    onPressed: () {
                      context.read<AuthBloc>().add(ChangePasswordEvent(password: passwordController.text));
                    },
                    child: const Text(
                      "Reset Password",
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
