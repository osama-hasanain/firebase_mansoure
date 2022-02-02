import 'package:firebase/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: defualtColor,
    accentColor: accentColor,
    fontFamily: 'Jannah',
    appBarTheme: AppBarTheme(
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,

        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defualtColor,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
      backgroundColor: Colors.white
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontFamily: 'Jannah'
      ),
      subtitle1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
        fontFamily: 'Jannah',
        height: 1.2
      ),
      subtitle2: TextStyle(
        color: Colors.black
      ),
      bodyText2: TextStyle(
        color:Colors.black,
      )
    ),
    iconTheme: IconThemeData(
      color: Colors.black
    ),
) ;

ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xFF333739),
    primarySwatch: defualtColor,
    accentColor: accentColor,
    fontFamily: 'Jannah',
    appBarTheme: AppBarTheme(
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xFF333739),
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Color(0xFF333739),
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.white54,
        )
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defualtColor,
      unselectedItemColor: Colors.grey,
      elevation: 20.0,
      backgroundColor: Color(0xFF333739),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontFamily: 'Jannah'
      ),
      subtitle1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        fontFamily: 'Jannah',
        height: 1.2
      ),
      subtitle2: TextStyle(
          color: Colors.white54
      ),
      bodyText2: TextStyle(
          color:Colors.white54,
      ),
      caption: TextStyle(
        color:Colors.white54
      ),
    ),
    hintColor: Colors.grey.shade700,
    iconTheme: IconThemeData(
      color: Colors.white54
  ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0))),
            side: MaterialStateProperty.all(BorderSide(
              color: Colors.grey.shade800,
            )),
          ),
    )

) ;