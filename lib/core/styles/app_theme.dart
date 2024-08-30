import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF5D9CEC);
  static const Color scaffoldBgColorlight = Color(0xFFDFECDB);
  static const Color scaffoldBgColordark = Color(0xFF060E1E);

  static const Color greyColor = Color(0xFFC8C9CB);
  static final ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    useMaterial3: false,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      titleTextStyle: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700, color: Colors.white)
    ),
        scaffoldBackgroundColor:  scaffoldBgColorlight,
    bottomAppBarTheme: BottomAppBarTheme(
      shape: CircularNotchedRectangle(),
      elevation: 20,

    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
backgroundColor: primaryColor,
       shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4))
  //RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(30),
      //     side: BorderSide(color: Colors.white, width: 4))

    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.transparent,
      elevation: 0,
      selectedItemColor: primaryColor,
      unselectedItemColor: greyColor,
      selectedIconTheme: IconThemeData(
        size: 30,
      )
    )
      ,textTheme: TextTheme(
      bodyMedium: TextStyle(color: Colors.black),
      // labelMedium: TextStyle(color: Colors.white)
  ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.white,
      outline: Colors.white,
        tertiary: Colors.black
    ),
  );

  static final ThemeData darkTheme = ThemeData(
      primaryColor: primaryColor,
      useMaterial3: false,
      appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          titleTextStyle: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700, color: Colors.black)
      ),
      scaffoldBackgroundColor:  scaffoldBgColordark,
      bottomAppBarTheme: BottomAppBarTheme(
        shape: CircularNotchedRectangle(),
        elevation: 20,

      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
//backgroundColor: Colors.red,
          shape: StadiumBorder(side: BorderSide(color: Color(0xFF141922), width: 4))
        //RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(30),
        //     side: BorderSide(color: Colors.white, width: 4))

      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF141922),
          elevation: 0,
          selectedItemColor: primaryColor,
          unselectedItemColor: greyColor,
          selectedIconTheme: IconThemeData(
            size: 30,
          )
      ),
textTheme: TextTheme(
  bodyMedium: TextStyle(color: Colors.white),
),
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: scaffoldBgColordark,
      outline: Color(0xFF141922),
      tertiary: Colors.white
    ),
  );




}



