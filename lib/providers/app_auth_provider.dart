import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:future_task_management_app/database_manager/model/user.dart'
as MyUser;
import 'package:future_task_management_app/database_manager/user_dao.dart';

class AppAuthProvider extends ChangeNotifier {
  User? firebaseAuthUser;
  MyUser.User? databaseUser;

  Future<void> register(
      String fullName, String userName, String email, String password) async {
    var credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    UserDao.addUser(MyUser.User(
      id: credential.user?.uid,
      fullName: fullName,
      userName: userName,
      email: email,
    ));
  }

  Future<void> login(String email, String password) async {
    var credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    var user = await UserDao.getUser(credential.user!.uid);
    databaseUser = user;
    firebaseAuthUser = credential.user;
//////////////////////////////////////////////////////////////////////////
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', email);
    await prefs.setString('password', password);

    notifyListeners();
  }

  Future<void> autoLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('email');
    String? password = prefs.getString('password');
    if (email != null && password != null) {
      await login(email, password);
    }
  }
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('email');
    await prefs.remove('password');

  }

}
