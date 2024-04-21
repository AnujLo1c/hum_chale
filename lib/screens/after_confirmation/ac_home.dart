import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// import 'package:hum_chale/models/TravelRoute.dart';
import 'package:hum_chale/models/trip.dart';
import 'package:hum_chale/screens/after_confirmation/ac_booking.dart';
import 'package:hum_chale/screens/after_confirmation/ac_itinerary.dart';
import 'package:hum_chale/screens/after_confirmation/ac_transit.dart';
import 'package:hum_chale/screens/after_confirmation/Expense_list.dart';
import 'package:hum_chale/screens/after_confirmation/packing_list.dart';
import 'package:hum_chale/screens/after_confirmation/todo_list.dart';
import 'package:hum_chale/screens/custom_bottom_nav.dart';
import 'package:hum_chale/ui/CustomColors.dart';
class Achome extends StatelessWidget {
  static var routeName = "ac-home";
   Achome({super.key});
final Trip trip= Trip(pickedImage:null,startDate:DateTime.now(),endDate:DateTime.now(),host:"anuj",title: "Goa Tour", price: "12000", index: 5, imageurl: 'sadfdsaf',pickUpPoint:"vijay nagar",activities:"activity1");
  final TravelRoute temp= TravelRoute(start: "A", dest: "N", time: "17:30", date: DateTime.now());

  final TravelRoute temp2=TravelRoute(start: "C", dest: "Na", time: "15:30", date: DateTime.now());

  final List<IconData> transit=[Icons.train,Icons.car_crash,Icons.airplanemode_active_rounded];

  final List<IconData> lodging=[Icons.home,Icons.house_outlined];
final List tempMember=["Anuj Lowanshi","Nandini Dhote"];

  @override

  Widget build(BuildContext context) {
precacheImage(const AssetImage("assets/images/aAfter-confirm.jpeg"), context);
    final Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              height: size.height/2,
              width: size.width,
              // color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                image: DecorationImage(image: AssetImage("assets/images/aAfter-confirm.jpeg"),fit: BoxFit.fill)
              ),
              child:  GestureDetector(
                onTap: ()=>membersInfo(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(trip.title,style: const TextStyle(letterSpacing: 1,fontSize: 36,fontWeight: FontWeight.bold,color: Colors.black54),),
                      // IconButton(padding: EdgeInsets.all(5),,icon: Icon(Icons.home), onPressed: () {  },)

                            const Spacer(),Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                           color: Colors.white.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(Radius.circular(15))
                        ),
                        child: InkWell(
                            onTap: ()=>Navigator.popUntil(context, (route) => route.settings.name==CustomBottomNav.routeName),
                            child: const Icon(color:Colors.black54,Icons.home_outlined,size: 36,)),
                      )
                      ],
                    ),
                  const Gap(3),
                    const Text("17 April",
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color:Colors.black45
                      ),),
                    const Spacer(),
                    Center(
                      child: Container(
                        width: size.width-120,
                        height: 60,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.2),
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          children: [
                            const Gap(10),
                            Container(
                                height: 40,
                                width: 40,
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.8),
                                  borderRadius: const BorderRadius.all(Radius.circular(30))
                                ),
                                child: const Icon(Icons.person_outline_rounded,size: 30,))
                          ,
                            const Spacer(),
                            const Text("Members",style: TextStyle(fontSize: 24,fontWeight: FontWeight.w700,color: Colors.black54),)
                          ,const Gap(20)
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

            ),
            const Gap(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ItemTile(Icons.mode_of_travel,"Itinerary",ACItinerary(itineraries:[temp,temp2]),context),
                ItemTile(Icons.luggage,"Packing List",const packingList(),context),
                ItemTile(Icons.list_alt,"To-do",const ToDo(),context)
              ],
            ),
            const Gap(30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ItemTile(Icons.wallet,"Expenses",const ExpenseList(),context),
                ItemTile(Icons.house,"Lodging",ACBooking(lodging:lodging),context),
                ItemTile(Icons.airplanemode_active_rounded,"Transit",ACTransit(transits: transit),context)
              ],
            ),
          ],
        ),
      ),
    );
  }

  ItemTile(IconData icon,String t, dynamic acItinerary,BuildContext context) {
    return InkWell(
      onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context) => acItinerary))
      ,child: SizedBox(
        height: 100,
        width: 100,
        child: Column(
          children: [
            const Gap(5),
            Container(
              height: 60,
              width: 60,
              decoration: const BoxDecoration(
                color: CustomColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Center(
                child: Icon(icon,size: 40,color: Colors.white,),
              ),
            ),
            const Gap(5),
            Text(t,style: const TextStyle(fontSize: 16),)
          ],
        ),
      ),
    );
  }

  membersInfo(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.white,
        child: Container(
          height: 300, // Adjust the height of the dialog
          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
          decoration: BoxDecoration(
            // color: Colors.black54,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: CustomColors.primaryColor,width: 3)
          ),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: tempMember.length,
                  itemBuilder: (context, index) => membertile(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  membertile(int index) {
return Container(
  margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
  decoration: BoxDecoration(
    borderRadius: const BorderRadius.all(Radius.circular(10),)
        ,color: Colors.grey.shade300,
      border: Border.all(color: Colors.black54,width: 3)
  ),
  // child: RichText(tempMember[index],style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
child: RichText(text: TextSpan(text:tempMember[index],style: const TextStyle(letterSpacing: 2,fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black87),
children: [const TextSpan(text: "\nAge: 21",style: TextStyle(letterSpacing:1,fontSize: 18,color: Colors.black54))]
)),
);
  }
}