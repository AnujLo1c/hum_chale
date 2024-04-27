import 'package:flutter/material.dart';

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
        style: const TextStyle(color: Colors.white, fontSize: 28),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      automaticallyImplyLeading: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
