import 'package:flutter/material.dart';
import 'package:future_task_management_app/core/route_manager/routes_manager.dart';
import 'package:future_task_management_app/providers/app_auth_provider.dart';
import 'package:provider/provider.dart';

import '../../providers/settings_provider.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  var settingsProvider;
  var appAuthProvider;
  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of<SettingsProvider>(context);
    appAuthProvider = Provider.of<AppAuthProvider>(context);
    Future.delayed(Duration(seconds:2 ),() {
      appAuthProvider.firebaseAuthUser != null ?
      Navigator.pushReplacementNamed(context, RouteManger.homeRoute):
      Navigator.pushReplacementNamed(context, RouteManger.loginRoute);
    },);
    return Image.asset(getSplashImg(), fit: BoxFit.fill,);
  }


  String getSplashImg(){
    return settingsProvider.currentTheme == ThemeMode.light ? "assets/images/splashLight.jpg" : "assets/images/splashDark.jpg";
  }

}