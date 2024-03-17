import 'package:assignment_6/data_layer/home_data_layer.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future setupDatabase() async{

  await dotenv.load(fileName: ".env");
  
  await Supabase.initialize(url: dotenv.env["subabaseUrl"]!, anonKey: dotenv.env["subabaseAnonKey"]!);
}

void setup(){
  
  GetIt.I.registerSingleton<HomeData>(HomeData());
}