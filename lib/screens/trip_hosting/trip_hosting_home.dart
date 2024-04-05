import 'package:flutter/material.dart';
import 'package:hum_chale/screens/custom_bottom_nav.dart';
// import 'package:hum_chale/widget/custom_bottom_nav.dart';
class TripHostingHome extends StatefulWidget {

  static var routeName= "trip-hosting-home";
  const TripHostingHome({super.key});

  @override
  State<TripHostingHome> createState() => _TripHostingHomeState();
}

class _TripHostingHomeState extends State<TripHostingHome> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      bottomNavigationBar: CustomBottomNav(),
    );
  }
}
