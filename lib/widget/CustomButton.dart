import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const CustomButton({super.key,required this.onTap,required this.text});

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    return Container(
        decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.blueAccent,
                  blurRadius: 6,
                  blurStyle: BlurStyle.normal
              )
            ]
        ),
        child: ElevatedButton(onPressed: onTap,
          child:Text(text,style: const TextStyle(fontSize: 20),),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Theme.of(context).primaryColor,
            minimumSize: Size(width, 50),

            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
          ),
        ),

    );
  }
}
