
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
class MyTheme {

  static const Color mainAppColor = Color(0xFF8F9F83);
  static const Color mainAppColorBright = Color(0xFFBDDBA6);
  static const Color mainAppBlueColor = Color(0xFF5787A6);
  static const Color mainAppBlueColorBright = Color(0xFF5787A6);
  static const MaterialColor mainAppSwatchColor = const MaterialColor(
    0xFF004685,
    const <int, Color>{
      50: const Color(0xFF8F9F83),
      100: const Color(0xFF8F9F83),
      200: const Color(0xFF8F9F83),
      300: const Color(0xFF8F9F83),
      400: const Color(0xFF8F9F83),
      500: const Color(0xFF8F9F83),
      600: const Color(0xFF8F9F83),
      700: const Color(0xFF8F9F83),
      800: const Color(0xFF8F9F83),
      900: const Color(0xFF8F9F83),
    },
  );
  static const MaterialColor mainAppBlueSwatchColor = const MaterialColor(
    0xFF004685,
    const <int, Color>{
      50: const Color(0xFF5787A6),
      100: const Color(0xFF5787A6),
      200: const Color(0xFF5787A6),
      300: const Color(0xFF5787A6),
      400: const Color(0xFF5787A6),
      500: const Color(0xFF5787A6),
      600: const Color(0xFF5787A6),
      700: const Color(0xFF5787A6),
      800: const Color(0xFF5787A6),
      900: const Color(0xFF5787A6),
    },
  );
 static ThemeData themeLight() =>
      ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: mainAppBlueColor
        ),
        primaryColor: mainAppBlueColor,
        primarySwatch: mainAppBlueSwatchColor,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: "beIN",
        textTheme: const TextTheme(
          headline1: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16
          ),
          headline4: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            letterSpacing: 0,
            fontFamily: "Muli",
          ),
          headline5: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            letterSpacing: 0.25,
            fontFamily: "Muli",
          ),
          bodyText1: TextStyle(
              color: Colors.white,
              fontSize: 16,

          ),
          bodyText2: TextStyle(
            color: mainAppBlueColor,
            fontSize: 14,
          ),
          button: TextStyle(color: Colors.white,fontSize: 14),
          overline: TextStyle(color: Colors.red,fontSize: 14),
          subtitle1: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
      );

 static ThemeData themeDark() =>
      ThemeData(
          primarySwatch: Colors.indigo,
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.grey.withOpacity(.1),
          appBarTheme: AppBarTheme(
              backwardsCompatibility: false,
              backgroundColor: mainAppBlueColor,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.black54,
                statusBarIconBrightness: Brightness.light,
              ),
              color: Colors.grey.withOpacity(.1),
              elevation: 0.0,
              iconTheme: const IconThemeData(
                  color: Colors.white
              ),
              titleTextStyle: const TextStyle(color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)
          ),
          bottomNavigationBarTheme:
          BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.indigo,
              elevation: 20,
              backgroundColor: Colors.grey.withOpacity(.1),
              unselectedItemColor: Colors.grey
          ),
          textTheme: const TextTheme(
            bodyText1: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            bodyText2: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
            subtitle1: TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          iconTheme: const
          IconThemeData(
              color: Colors.white, opacity: 1
          )
      );

 static ThemeData defaultAppTextTheme() => ThemeData(
     appBarTheme: AppBarTheme(
              backgroundColor: mainAppBlueColor,
     ),
   fontFamily: "beIN",
   textTheme: TextTheme(
     button: TextStyle(color: Colors.white,fontSize: 14),
     overline: TextStyle(color: Colors.red,fontSize: 14),
     headline1: TextStyle(color: Colors.white,fontSize: 24,fontWeight: FontWeight.bold),
     headline2: TextStyle(color: Colors.white,fontSize: 20),
     bodyText1: TextStyle(color: Colors.white,fontSize: 18),
   )
 ) ;
}