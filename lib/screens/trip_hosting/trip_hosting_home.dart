import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/screens/trip_hosting/trip_itinary.dart';

import 'package:hum_chale/widget/CustomButton.dart';
import 'package:hum_chale/widget/Custom_text_field_2.dart';
import 'package:hum_chale/screens/trip_hosting/trip_itinary.dart';
class TripHostingHome extends StatelessWidget {
  static var routeName= "trip-hosting-home";
   TripHostingHome({super.key});
  final TextEditingController TECtitle=TextEditingController();
  final TextEditingController TECpickUpPoint=TextEditingController();
  final TextEditingController TECprice=TextEditingController();
  final TextEditingController TECactivities=TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return  Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
      child: Column(
        children: [
          Gap(5),
          Align(
              alignment: AlignmentDirectional.topStart,child: Text("Trip Hosting",style: TextStyle(fontWeight: FontWeight.w900,fontSize: 34,color: Theme.of(context).primaryColor),))
          ,Gap(20),CustomTextField2(textEditingController: TECtitle, hintText: 'Trip Title', w: 300,),
          Gap(10),
          CustomTextField2(textEditingController: TECpickUpPoint, hintText: 'Pick up Point', w: 200,),
        Gap(15)
        ,Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Gap(2),
              Text("Price",style:  TextStyle(fontSize: 28,color: Colors.black,fontWeight: FontWeight.w600),
              ),Gap(10),
              CustomTextField2(textEditingController: TECprice, hintText: "PP",w: 150,size: size.width/2-100),
            ],
          ),
          Gap(15),
          CustomTextField2(textEditingController: TECactivities, hintText: "Activities included", w: 200,height: 5),
          Gap(30),
          CustomButton(onTap: ()=>Navigator.pushNamed(context,TripItinerary.routeName ),text: "Next",)
        ],
      ),
    );
  }
}
