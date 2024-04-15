

import 'package:flutter/material.dart';

import 'package:hum_chale/screens/custom_bottom_nav.dart';

class Explore extends StatelessWidget {
  static var routeName = "explore-screen";
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("assets/images/explore.jpg"), context);
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
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
            image: AssetImage("assets/images/explore.jpg"),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText(Size size) {

    return  Positioned(
      left: (size.width/2)-138,
      top: 70,
      child:  SizedBox(
        width: 309,
        height: 73,
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            style:TextStyle(color: Colors.black54,fontSize: 20),
            children: [
              TextSpan(text: "Enjoy your journey with\n"),
              TextSpan(text: "Hum Chale",style: TextStyle(
                fontSize: 32,fontWeight: FontWeight.bold
              ))
            ]
          ),
        ),
        // child: Text(
        //   'HUM CHALE ',
        //   style: TextStyle(
        //     shadows: [
        //       Shadow(color: Colors.black,blurRadius: 15,),
        //     ],
        //     color: Colors.white,
        //     fontSize: 48,
        //     fontFamily: 'Playfair Display',
        //     fontWeight: FontWeight.w800,
        //     height: 1.0,
        //   ),
        // ),
      ),
    );
  }

  Widget _buildButton(Size size, BuildContext context) {
    return  Positioned(
      left: (size.width/2)-95,
      top: size.height-130,
      child: SizedBox(
        height: 40,
        width: 200,
        child: ElevatedButton(

          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFFFFF).withOpacity(.05),
              side: const BorderSide(color: Colors.white,width: 2,),
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))),
          onPressed: () {
            Navigator.pushNamed(context,CustomBottomNav.routeName);
          },
          child: const Text(
            'Explore',
            style: TextStyle(

              color: Colors.white,
              fontSize: 22,
              fontFamily: 'Playfair Display',
              fontWeight: FontWeight.w800,
            ),

          ),
        ),
      ),
    );
  }
}
