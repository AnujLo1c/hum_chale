import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hum_chale/authentication/email_verification_screen.dart';
import 'package:hum_chale/firebase/firebase_options.dart';
import 'package:hum_chale/models/TravelRoute.dart';
import 'package:hum_chale/screens/InitialLoginScreens/login_page.dart';
import 'package:hum_chale/screens/InitialLoginScreens/sign_up.dart';
import 'package:hum_chale/screens/InitialLoginScreens/sign_up_google.dart';
import 'package:hum_chale/screens/InitialLoginScreens/splash_screen.dart';
import 'package:hum_chale/screens/InitialLoginScreens/start_page.dart';
import 'package:hum_chale/screens/trip_booking/explore.dart';
import 'package:hum_chale/screens/trip_booking/add_members.dart';
import 'package:hum_chale/screens/custom_bottom_nav.dart';
import 'package:hum_chale/ui/app_theme.dart';
import 'package:hum_chale/screens/trip_hosting/trip_itinary.dart';
import 'package:hum_chale/screens/trip_hosting/trip_transit.dart';
import 'package:hum_chale/screens/trip_hosting/trip_lodging.dart';
import 'package:hum_chale/screens/after_confirmation/ac_home.dart';
import 'package:hum_chale/authentication/email_verification_screen.dart';
import 'package:hum_chale/authentication/forgot_password.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        SignUpG.routeName: (context) => const SignUpG(),
        Explore.routeName: (context) => const Explore(),
        CustomBottomNav.routeName: (context) => const CustomBottomNav(),
        TripItinerary.routeName:(context)=>const TripItinerary(),
        TripTransit.routeName:(context)=>const TripTransit(),
        TripLodging.routeName:(context)=>const TripLodging(),
        AddMembers.routeName:(context)=>const AddMembers(),
        Achome.routeName:(context) => Achome(),
        EmailVerificationScreen.routeName:(context) => const EmailVerificationScreen(),
        ForgotPassword.routeName:(context) => const ForgotPassword(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
