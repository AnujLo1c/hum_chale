import 'package:flutter/material.dart';

import 'package:hum_chale/screens/custom_bottom_nav.dart';

class Explore extends StatelessWidget {
  static var routeName = "explore-screen";
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    // precacheImage(const AssetImage("assets/images/explore.jpg"), context);
    final Size screenSize = MediaQuery.of(context).size;

    return PopScope(
      canPop: true,
      child: SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: screenSize.width,
            height: screenSize.height,
            child: Stack(
              children: [
                _buildBackgroundImage(screenSize),
                _buildHeaderText(screenSize),
                _buildButton(screenSize, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundImage(Size size) {
    return Positioned(
      left: 0,
      top: 0,
      child: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/explore.jpg"),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText(Size size) {
    return Positioned(
      left: (size.width / 2) - 138,
      top: 70,
      child: SizedBox(
        width: 309,
        height: 73,
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
              style: TextStyle(color: Colors.white, fontSize: 24),
              children: [
                TextSpan(text: "Enjoy your journey with\n"),
                TextSpan(
                    text: "Hum Chale",
                    style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold))
              ]),
        ),
      ),
    );
  }

  Widget _buildButton(Size size, BuildContext context) {
    return Positioned(
      left: (size.width / 2) - 135,
      top: size.height - 130,
      child: SizedBox(
        height: 60,
        width: 280,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFFFFF).withOpacity(.07),
              side: const BorderSide(
                color: Colors.white,
                width: 2,
              ),
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
          onPressed: () {
            Navigator.pushNamed(context, CustomBottomNav.routeName);
          },
          child: const Text(
            'Explore',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}