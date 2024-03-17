import 'package:assignment_6/bloc/auth_bloc.dart';
import 'package:assignment_6/pages/email_confirm_page.dart';
import 'package:assignment_6/pages/signup_page.dart';
import 'package:assignment_6/utils/setup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDatabase();
  setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp(debugShowCheckedModeBanner: false, home: SignUpPage()),
    );
  }
}
