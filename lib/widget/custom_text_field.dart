
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final double w;
  CustomTextField({super.key,required this.textEditingController,required this.hintText,required this.w});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: w,
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: w<60?16:18),
          fillColor: Colors.grey.shade200
          ,border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: Colors.black
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))
          )
        ),
      ),
    );
  }
}
