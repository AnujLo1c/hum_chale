import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hum_chale/screens/InitialLoginScreens/login_page.dart';

class StartPage extends StatelessWidget {
  static String routeName="/start-page";
   const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // precacheImage(const AssetImage("assets/images/start-page.jpeg"), context);

    final Size screenSize = MediaQuery.of(context).size;

    return PopScope(
      canPop: true,
      onPopInvoked: (onPop){
        exit(0);
      },
      child: SafeArea(
        child: Scaffold(
          body: SizedBox(
            width: screenSize.width,
            height: screenSize.height,
            child: Stack(
              children: [
                _buildBackgroundImage(),
                _buildHeaderText(screenSize),
                _buildButton(screenSize,context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned(
      left: -7,
      top: 0,
      child: Container(
        width: 437,
        height: 961,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/start-page.jpeg"),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText(Size size) {

    return  Positioned(
      left: (size.width / 5),
      top: 70,
      child: const Center(
        child: Text(
          'HUM CHALE ',
          style: TextStyle(
            shadows: [
              Shadow(
                color: Colors.white,
                blurRadius: 7,
              ),
            ],
            color: Colors.white,
            fontSize: 40,
            fontFamily: 'Playfair Display',
            fontWeight: FontWeight.w800,
            height: 1.0,
          ),
        ),
      ),
    );
  }

  Widget _buildButton(Size size, BuildContext context) {
    MaterialStateProperty<Color> bg=MaterialStateProperty.resolveWith((states) => const Color(0xFFFFFFFF).withOpacity(.05));
    MaterialStateProperty<BorderSide> border=MaterialStateProperty.resolveWith((states) => const BorderSide(color: Colors.white,width: 2,));
    return  Positioned(
      left: (size.width/2)-125,
      top: size.height-130,
      child: SizedBox(
        height: 50,
        width: 250,
        child: ElevatedButton(

          style: ButtonStyle(backgroundColor: bg,side: border),
          onPressed: () {
            Navigator.pushNamed(context,LoginPage.routeName);
          },
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween
            ,
            children: [
              Text(
                '  Begin your journey',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Playfair Display',
                  fontWeight: FontWeight.w800,
                ),
              ),
              Icon(Icons.chevron_right,color: Colors.white,size: 37)
            ],
          ),
        ),
      ),
    );
  }
}
