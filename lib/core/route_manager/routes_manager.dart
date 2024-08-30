import 'package:flutter/material.dart';
import 'package:future_task_management_app/ui/Splash/splashScreen.dart';
import 'package:future_task_management_app/ui/home/auth/login/login_screen.dart';
import 'package:future_task_management_app/ui/home/auth/register/register_screen.dart';
import 'package:future_task_management_app/ui/home/home_screen.dart';

class RouteManger {
  static const String registerRoute = '/register';
  static const String loginRoute = '/login';
  static const String homeRoute = '/home';
  static const String splashScreen = '/';


  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginRoute:
        {
          return MaterialPageRoute(
            builder: (context) => LoginScreen(),
          );
        }
      case registerRoute:
        {
          return MaterialPageRoute(
            builder: (context) => RegisterScreen(),
          );
        }
      case homeRoute:
        {
          return MaterialPageRoute(
            builder: (context) => HomeScreen(),
          );
        }
      case splashScreen:
        {
          return MaterialPageRoute(
            builder: (context) => SplashScreen(),
          );
        }
    }
  }
}