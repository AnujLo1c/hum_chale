import 'package:flutter/material.dart';
// import 'package:hum_chale/models/TravelRoute.dart';
import 'package:gap/gap.dart';
// import 'package:hum_chale/models/TravelRoute.dart';
import 'package:hum_chale/models/trip.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:intl/intl.dart';

class ACItinerary extends StatelessWidget {

  static var routeName = "ac-itinerary";
  final List<TravelRoute> itineraries;

  ACItinerary({super.key, required this.itineraries});
  // List<TravelRoute> itineraries=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
            color: CustomColors.primaryColor,
          ),
          title: const Text(
            "Itinerary",
            style: TextStyle(fontSize: 28, color: CustomColors.primaryColor),
          ),
        ),
        body: Column(
          children: [
            const Divider(
              color: CustomColors.primaryColor,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: itineraries.length,
                itemBuilder:(context, index) => itineraryTile(index),
            ),
          ),
        ],
      )

    );
  }

Widget itineraryTile(int index) {
  TravelRoute r = itineraries.elementAt(index);
  // Route r1 = iti
  return Container(
      margin: const EdgeInsets.only(right: 20,left: 20,top: 10,bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
      height: 70,
      decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(width: 2, color: CustomColors.primaryColor)),
        child: Column(
          children: [
            Row(children: [
              Text(
                r.start.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_right_alt,
                size: 30,
              ),
              const Spacer(),
              Text(r.dest.toString(), style: const TextStyle(fontSize: 20)),
            ]),
            const Gap(5),
            Row(
              children: [
                Text(DateFormat.MMMEd().format(r.date!)),
                const Spacer(),
                Text(
                  r.time,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                )
                // String formattedDate = DateFormat('yyyy-MM-dd').format(now);
              ],
            )
          ],
        ));
  }
}