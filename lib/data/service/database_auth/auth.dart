import 'dart:async';

import 'package:app_github_connection/data/data_layer.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DBService {
  final supabase = Supabase.instance.client;
  final locator = GetIt.I.get<AllData>();

//--- SignUp func
  Future SignUp({required String email, required String password}) async {
    await supabase.auth.signUp(email: email, password: password);
    // Send email verification
    await supabase.auth.resetPasswordForEmail(email);
  }

  Future SignIn({required String email, required String password}) async {
    await supabase.auth.signInWithPassword(email: email, password: password);
    locator.token = supabase.auth.currentSession!.accessToken;
    locator.addToken();
  }

  //Future SignOut
  Future SignOut() async {
    await supabase.auth.signOut();
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    final response = await supabase.auth.resetPasswordForEmail(email);
    return response;
  }
}
