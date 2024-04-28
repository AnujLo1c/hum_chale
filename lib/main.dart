import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hum_chale/authentication/email_verification_screen.dart';
import 'package:hum_chale/firebase/firebase_options.dart';
import 'package:hum_chale/models/trip.dart';
// import 'package:hum_chale/models/TravelRoute.dart';
import 'package:hum_chale/screens/InitialLoginScreens/login_page.dart';
import 'package:hum_chale/screens/InitialLoginScreens/sign_up.dart';
import 'package:hum_chale/screens/InitialLoginScreens/sign_up_google.dart';
import 'package:hum_chale/screens/InitialLoginScreens/splash_screen.dart';
import 'package:hum_chale/screens/InitialLoginScreens/start_page.dart';
import 'package:hum_chale/screens/profile/trip_booking_status.dart';
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
import 'package:hum_chale/screens/profile/trip_history.dart';
import 'package:hum_chale/screens/profile/hosted_trip_request.dart';
import 'package:hum_chale/screens/profile/hosted_trip_request_selection.dart';

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
        TripItinerary.routeName:(context)=> TripItinerary(trip: ModalRoute.of(context)!.settings.arguments as Trip),
        TripTransit.routeName:(context)=>TripTransit(trip: ModalRoute.of(context)!.settings.arguments as Trip),
        TripLodging.routeName:(context)=> TripLodging(trip: ModalRoute.of(context)!.settings.arguments as Trip),
        HostedTRSelection.routeName: (context) => HostedTRSelection(
            id: ModalRoute.of(context)!.settings.arguments as String),
        TripHistoryScreen.routeName: (context) => TripHistoryScreen(
            tripHistoryList:
                ModalRoute.of(context)!.settings.arguments as List<dynamic>),
        TripBookingStatus.routeName: (context) => TripBookingStatus(
            tripBookingStatus:
                ModalRoute.of(context)!.settings.arguments as List<dynamic>),
        HostedTripRequest.routeName: (context) => HostedTripRequest(
            tripHostings:
                ModalRoute.of(context)!.settings.arguments as List<dynamic>),
        AddMembers.routeName: (context) => AddMembers(
            tripReq:
                ModalRoute.of(context)!.settings.arguments as TripJoinRequest),
        Achome.routeName:(context) => Achome(),
        EmailVerificationScreen.routeName:(context) => const EmailVerificationScreen(),
        ForgotPassword.routeName:(context) => const ForgotPassword(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
