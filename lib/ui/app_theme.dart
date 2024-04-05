import 'package:flutter/material.dart';
class AppTheme{
   static ThemeData get MyThemeData=>ThemeData(
    useMaterial3: true,
    primaryColor: const Color(0xFF4FC3DC),
   scaffoldBackgroundColor: Color(0xFFD3F7FF),

    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      )
    )
  );
}