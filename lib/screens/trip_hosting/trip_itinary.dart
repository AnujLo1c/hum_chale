import 'package:flutter/material.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/widget/CustomAppBar.dart';
class TripItinerary extends StatefulWidget {
  static var routeName="trip-itinerary";
  const TripItinerary({super.key});

  @override
  State<TripItinerary> createState() => _TripItineraryState();
}

class _TripItineraryState extends State<TripItinerary> {
  List<dynamic> itineraries=[];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(),
          floatingActionButton: FloatingActionButton(
            onPressed: ()=>AddItem(),
            child: Icon(Icons.add,color: Colors.white,),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        ));
  }

  AddItem() {
    return showDialog(context: context,
        builder: (context) => Dialog(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: CustomColors.primaryColor,width: 2,),
              borderRadius: BorderRadius.all(Radius.circular(25))
            ),
            padding: EdgeInsets.all(10),
            height: 200,width: 300,
            child: Text("sdjkhafjk"),
          ),
        ),
    );
  }
}
class Route{
  final String start,dest,time;
  final DateTime date;

  Route({required this.start, required this.dest, required this.time, required this.date});
}