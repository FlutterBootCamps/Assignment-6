import 'package:supabase_flutter/supabase_flutter.dart';

class DBService {
  final supabase = Supabase.instance.client;


  Future signup({required String email, required String password}) async{
    await supabase.auth.signUp(email: email,password: password,);
  }

  Future signin({required String email, required String password}) async {
    await supabase.auth.signInWithPassword(email: email ,password: password);
  }

  Future signout() async {
    await supabase.auth.signOut();
  }

  Future resend({required String email}) async {
    await supabase.auth.resend(type: OtpType.signup, email: email);
  }

  Future resetPassword({required String email}) async {
    await supabase.auth.resetPasswordForEmail(email,);
  }

  Future sendOtp({required String email}) async {
    await supabase.auth.signInWithOtp(
      email: email,
      shouldCreateUser: false,

    );
  }
  Future verifyOtp({required String email, required String otpToken}) async {
    await supabase.auth.verifyOTP(token: otpToken, type: OtpType.email, email: email);
  }

  Future changePassword({required String password}) async {
    await supabase.auth.updateUser(UserAttributes(password: password));
  }
}