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
      appBarTheme: const AppBarTheme(
        color: defaultBackgroundColor,
        elevation: 0,
        titleTextStyle: TextStyle(color: Colors.white, fontFamily: 'Cairo'),
        actionsIconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      scaffoldBackgroundColor: defaultBackgroundColor,
      tabBarTheme: TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: defaultColor),
      fontFamily: 'Cairo',
      primaryTextTheme: const TextTheme(
          titleMedium: TextStyle(
        color: Colors.white,
      )),
      textSelectionTheme: const TextSelectionThemeData(cursorColor: defaultColor),
      inputDecorationTheme: InputDecorationTheme(
        //filled: true,
        fillColor: Colors.white,
        prefixIconColor: Colors.white,
        suffixIconColor: Colors.white,
        errorStyle: TextStyle(color: Colors.red, fontSize: 10.sp),
        labelStyle: const TextStyle(
          color: Colors.white,
        ),

        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(
          color: defaultColor,
        ),
            borderRadius: BorderRadius.circular(15)),
        enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
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
