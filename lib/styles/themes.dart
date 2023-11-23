import 'package:bebo_auto_service/components/constans.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

ThemeData darkTheme(context) => ThemeData(
      bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.grey[900],
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20)))),
      appBarTheme:
          const AppBarTheme(color: defaultBackgroundColor, elevation: 0),
      scaffoldBackgroundColor: defaultBackgroundColor,
      fontFamily: 'Cairo',
      primaryTextTheme: const TextTheme(
          titleMedium: TextStyle(
        color: Colors.white,
      )),
      inputDecorationTheme: InputDecorationTheme(
        //filled: true,
        fillColor: Colors.white,
        prefixIconColor: Colors.white,
        suffixIconColor: Colors.white,
        errorStyle: TextStyle(
            color: Colors.red,
            fontSize: 10.sp
        ),
        labelStyle: const TextStyle(
          color: Colors.white,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(15)),
      ),
      primarySwatch: Colors.red,
      secondaryHeaderColor: Colors.white,
      primaryColor: Colors.black,
      highlightColor: Colors.grey[900],
      hoverColor: Colors.grey[800],
      hintColor: Colors.white54,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
            color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
      ),
    );

ThemeData lightTheme(context) => ThemeData(
      appBarTheme: const AppBarTheme(
        color: Colors.white,
        elevation: 0,
        toolbarHeight: 60,
        titleTextStyle: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        actionsIconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      scaffoldBackgroundColor: Colors.white,
      fontFamily: 'RobotoCondensed',
      inputDecorationTheme: InputDecorationTheme(
        //filled: true,
        //fillColor: Colors.black,
        prefixIconColor: Colors.black,
        suffixIconColor: Colors.black,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(20)),
      ),

      primarySwatch: Colors.purple,
      secondaryHeaderColor: Colors.black,
      primaryColor: Colors.white,

      ///Color.fromARGB(255, 224, 224, 224),
      highlightColor: Color.fromARGB(255, 224, 224, 224),
      hoverColor: Colors.grey[400],
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Color.fromARGB(255, 224, 224, 224),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20)))),

      textTheme: TextTheme(
        bodyLarge: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.w900),
      ),
    );
