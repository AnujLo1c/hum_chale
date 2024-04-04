import 'package:flutter/material.dart';
import 'package:hum_chale/screens/InitialLoginScreens/login_page.dart';
import 'package:hum_chale/screens/InitialLoginScreens/sign_up.dart';
import 'package:hum_chale/screens/InitialLoginScreens/splash_screen.dart';
import 'package:hum_chale/screens/InitialLoginScreens/start_page.dart';
import 'package:hum_chale/screens/trip_booking/explore.dart';
import 'package:hum_chale/screens/trip_booking/trip_booking_home.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
    SplashScreen.routeName:(context)=>const SplashScreen(),
    StartPage.routeName:(context)=>const StartPage(),
    LoginPage.routeName:(context)=>const LoginPage(),
    SignUp.routeName:(context)=>const SignUp(),
    Explore.routeName:(context)=>const Explore(),
        TripBookingHome.routeName:(context)=>const TripBookingHome()
    },
      initialRoute: SplashScreen.routeName,
    );
  }
}


