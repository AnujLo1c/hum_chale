import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hum_chale/screens/InitialLoginScreens/start_page.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  static String routeName="splash-screen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    Timer(const Duration(
        seconds: 3
    ), (){Navigator.pushNamed(context, StartPage.routeName);});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: Center(
          child: SizedBox(
            height: 350,
            width: 350,
            child:Lottie.asset("assets/lotti_animations/splash.json"),
          ),
        )
    );
  }
}