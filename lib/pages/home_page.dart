import 'package:assignment_6/bloc/auth_bloc.dart';
import 'package:assignment_6/helpers/extensions/screen_helper.dart';
import 'package:assignment_6/pages/login_page.dart';
import 'package:assignment_6/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          context.push(context, LoginPage(), false);
          context.read<AuthBloc>().add(SignoutEvent());
        }, icon: const Icon(Icons.logout_rounded, color: blackColor,)),
      ),
      body: const Center(
        child: Text("Home Page", style: TextStyle(color: blackColor, fontSize: 24),),
      ),
    );
  }
}