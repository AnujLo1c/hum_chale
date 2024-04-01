import 'package:flutter/material.dart';
import 'package:hum_chale/screens/splash_screen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Hum Chale',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
    SplashScreen.routeName:(context)=>const SplashScreen(),
    },
      initialRoute: SplashScreen.routeName,
    );
  }
}


