import 'package:app_github_connection/helper/extintion.dart';
import 'package:app_github_connection/helper/sized.dart';
import 'package:app_github_connection/pages/signin/signin_page.dart';
import 'package:app_github_connection/pages/signup/bloc/signup_bloc.dart';
import 'package:app_github_connection/widgets/text_fiels_widget.dart';
import 'package:flutter/material.dart';
import 'package:app_github_connection/helper/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController secondNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<SignUpBloc>();
        return Scaffold(
          backgroundColor: white,
          body: SafeArea(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/Sign up-rafiki.png',
                    width: 200,
                  ),
                  gapH20,
                  const Text(
                    "Let's Get Started",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 30),
                  ),
                  BlocConsumer<SignUpBloc, SignUpState>(
                    listener: (context, state) {
                      if (state is LoadingState) {
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
                      if (state is SuccessState) {
                        Navigator.pop(context);
                        context.pushTo(view: SigninPage());
                      }
                      if (state is ErrorState) {
                        Navigator.pop(context);
                        context.getDialog(
                            content:
                                'there is some error in the email or password');
                      }
                    },
                    builder: (context, state) {
                      return Column(
                        children: [
                          const Text("Create a new account"),
                          gapH10,
                          TextFieldWidget(
                            label: "Name",
                            hintText: "Name",
                            controller: firstNameController,
                          ),
                          gapH10,
                          gapH5,
                          TextFieldWidget(
                            label: "Phone",
                            hintText: "05*******",
                            controller: secondNameController,
                          ),
                          gapH10,
                          gapH5,
                          TextFieldWidget(
                            label: "Email",
                            hintText: "gmail@gmail.com",
                            controller: emailController,
                          ),
                          gapH10,
                          gapH5,
                          TextFieldWidget(
                            label: "Password",
                            hintText: "*********",
                            controller: passwordController,
                          ),
                          gapH20,
                          MaterialButton(
                            color: Colors.red.shade200,
                            onPressed: () async {
                              bloc.add(CreateAccountEvent(
                                email: emailController.text,
                                password: passwordController.text,
                              ));
                            },
                            child: const Text("SignUp"),
                          ),
                        ],
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Have an account?"),
                      TextButton(
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SigninPage(),
                                ),
                                (route) => false);
                          },
                          child: const Text("Sign in")),
                    ],
                  )
                ],
              ),
            ),
          )),
        );
      }),
    );
  }
}
