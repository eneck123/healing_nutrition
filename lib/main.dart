import 'package:flutter/material.dart';
//import 'package:flutter_application_1/authentificate/auth_service.dart';
import 'package:flutter_application_1/models/user_model.dart';
import 'package:flutter_application_1/screens/password_modify.dart';
import 'package:flutter_application_1/screens/reset_password_screen.dart';
import 'package:flutter_application_1/screens/verify_code_screen.dart';

import 'screens/healing_app_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/personal_info1_screen.dart';
import 'screens/objective_screen.dart';
import 'screens/personal_info2_screen.dart';
import 'screens/personal_info3_screen.dart';
import 'screens/personal_info4_screen.dart';
import 'package:provider/provider.dart';


//import 'models/user_registration_service.dart';
//import 'dart:async';

void main() async {
  runApp(
    ChangeNotifierProvider(
      create: (context) => UserModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Healing Nutrition',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
       '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
        '/healing_app': (context) => const HealingAppScreen(), 
        '/objective': (context) => const ObjectiveScreen(), 
        '/personal_info1': (context) => const PersonalInfo1Screen(), 
        '/personal_info2': (context) => const PersonalInfo2Screen(), 
        '/personal_info3': (context) => const PersonalInfo3Screen(), 
        '/personal_info4': (context) => const PersonalInfo4Screen(), 
        '/password_modify': (context) => const PasswordModify(), 
        '/verify_code_screen': (context) => VerifyCodeScreen(), 
        '/reset_password_screen': (context) => const ResetPasswordScreen(), 



          

        
       },

    );
  }
}


