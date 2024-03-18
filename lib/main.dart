import 'package:app_github_connection/data/data_layer.dart';
import 'package:app_github_connection/data/service/supabase_configration.dart';
import 'package:app_github_connection/pages/home_page.dart';
import 'package:app_github_connection/pages/signin/signin_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await databaseConfig();
  await setup();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<AllData>();
    locator.getToken();
    // locator.deleteToken();
    return MaterialApp(
      home: locator.token.isNotEmpty ? const HomePage() : SigninPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
