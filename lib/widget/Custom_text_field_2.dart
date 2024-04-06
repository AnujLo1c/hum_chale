import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as Flutter;
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class CustomTextField2 extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final double w;

  CustomTextField2({
    Key? key, // Key parameter added
    this.height,
    this.size,
    required this.textEditingController,
    required this.hintText,
    required this.w,
  }) : super(key: key); // super(key: key) added

  final  height; // Corrected parameter name
  final  size; // Added parameter for width control


  @override
  Widget build(BuildContext context) {
    final double verticalPadding = w > 300.0 ? 4 : 0;
    final double horizontalPadding = 12;

    return Container(
      width: size == null ? MediaQuery.of(context).size.width : size,
      // height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: const GradientBoxBorder(
          width: 2,
          gradient: Flutter.LinearGradient(colors: [
            Colors.blueAccent,
            Colors.blue,
            Colors.lightBlue,
            Colors.lightBlueAccent
          ]),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: Center(
        child: TextField(
          maxLines: height,
          style: TextStyle(fontSize: w / 10),
          controller: textEditingController,
          textAlign: height==null?TextAlign.center:TextAlign.start,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(fontSize: w / 10),
          ),
        ),
      ),
    );
  }
}
