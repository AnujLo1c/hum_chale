import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  String? text;
  @override
  CustomAppBar({super.key, this.text});

  @override
  Widget build(BuildContext context) {
    return AppBar(
centerTitle: true
      ,title: Text(
        (text == null) ? "Hum Chale" : text!,
        style: GoogleFonts.freehand(
          letterSpacing: 2,
          color: Colors.white,
          fontSize: 32,
        ),
        // TextStyle(letterSpacing: )
      ),
      backgroundColor: Theme.of(context).primaryColor,
      automaticallyImplyLeading: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
