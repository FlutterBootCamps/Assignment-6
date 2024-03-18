import 'package:app_github_connection/helper/colors.dart';
import 'package:app_github_connection/pages/signin/bloc/signin_bloc.dart';
import 'package:app_github_connection/widgets/text_fiels_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInBloc, SignInState>(
      listener: (context, state) {
        if (state is LoadingSignInState) {
          showDialog(
              barrierDismissible: false,
              barrierColor: Colors.transparent,
              context: context,
              builder: (context) {
                return const AlertDialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  content: SizedBox(
                    height: 80,
                    width: 80,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                );
              });
        }
        if (state is SuccessSignInState) {
          Navigator.pop(context);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password reset email sent')),
          );
        }
        if (state is ErrorSignInState) {
          Navigator.pop(context);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.massage),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (context, state) {
        final bloc = context.read<SignInBloc>();
        return TextButton(
            onPressed: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Forgot password?",
                              style: TextStyle(
                                  color: black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                                "We just need your Registered Email to send you password reset instruction"),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFieldWidget(
                              label: "Registered Email",
                              hintText: "Registered Email",
                              controller: controller,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 50,
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  bloc.add(ResetPasswordEvent(
                                      email: controller.text));
                                },
                                child: Text(
                                  "Reset Password",
                                  style: TextStyle(color: white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            )
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: const Text("Forgot Password?"));
      },
    );
  }
}
