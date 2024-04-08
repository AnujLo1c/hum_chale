import 'package:flutter/material.dart';
import 'package:hum_chale/screens/InitialLoginScreens/login_page.dart';
import 'package:hum_chale/screens/InitialLoginScreens/sign_up.dart';
import 'package:hum_chale/screens/InitialLoginScreens/splash_screen.dart';
import 'package:hum_chale/screens/InitialLoginScreens/start_page.dart';
import 'package:hum_chale/screens/trip_booking/explore.dart';
import 'package:hum_chale/screens/trip_booking/trip_booking_home.dart';
import 'package:hum_chale/screens/trip_booking/product_details_screen.dart';
import 'package:hum_chale/screens/trip_hosting/trip_hosting_home.dart';
import 'package:hum_chale/screens/custom_bottom_nav.dart';
import 'package:hum_chale/ui/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/images/start-page.jpg"), context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hum Chale',
      theme: AppTheme.MyThemeData,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        StartPage.routeName: (context) => const StartPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        SignUp.routeName: (context) => const SignUp(),
        Explore.routeName: (context) => const Explore(),
        CustomBottomNav.routeName: (context) => const CustomBottomNav(),
      },
      // initialRoute: SplashScreen.routeName,
      initialRoute: SplashScreen.routeName,
    );
  }
}
