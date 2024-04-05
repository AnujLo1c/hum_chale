import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override


  CustomAppBar({super.key,});

  @override
  Widget build(BuildContext context) {
    return AppBar(
centerTitle: true
      ,title: Text(
        "Hum Chale",
        style: TextStyle(color: Colors.white,fontSize: 28),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      automaticallyImplyLeading: true,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
