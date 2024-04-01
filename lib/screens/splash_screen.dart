import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hum_chale/screens/start_page.dart';

class SplashScreen extends StatefulWidget {
  // MainMenu.routeName:(context)=>const MainMenu(),
  static String routeName="/splash-screen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
@override
  void initState() {
    // TODO: implement initState
  Timer(const Duration(
    seconds: 2
  ), ()=>Navigator.pushNamed(context, StartPage.routeName));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
