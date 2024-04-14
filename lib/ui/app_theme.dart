import 'package:flutter/material.dart';
import 'package:hum_chale/ui/CustomColors.dart';
class AppTheme{
   static ThemeData get MyThemeData=>ThemeData(
    useMaterial3: true,
    primaryColor: const Color(0xFF4FC3DC),
   // scaffoldBackgroundColor: Color(0xFFD3F7FF),
   scaffoldBackgroundColor: const Color(0xFFFFFFFF),

    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),

      )
    ),
       floatingActionButtonTheme: FloatingActionButtonThemeData(
         backgroundColor: CustomColors.primaryColor,
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30)),
       side: BorderSide(width: 1,color: Colors.white60)
       )
   ),
     dialogTheme: DialogTheme(
       backgroundColor: Colors.white,
       elevation: 5,
       shadowColor: Colors.black,
       contentTextStyle: TextStyle(
         fontSize: 24,
         color: Colors.black45,

       )
     )

  );
}