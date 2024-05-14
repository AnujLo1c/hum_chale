import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/screens/profile/hosted_trip_request_selection.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/widget/CustomAppBar.dart';
import 'package:intl/intl.dart';

class HostedTripRequest extends StatefulWidget {
  static String routeName = "hosted-trip-request";

  final List<dynamic> tripHostings;

  const HostedTripRequest({super.key, required this.tripHostings});

  @override
  State<HostedTripRequest> createState() => _HostedTripRequestState();
}

class _HostedTripRequestState extends State<HostedTripRequest> {
  var ff = FirebaseFirestore.instance.collection("trips");
  List<TempTrip> hostedTrips = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.tripHostings != [] ? fetchTripData() : null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(text: "Booking Requests"),
        body: hostedTrips.isNotEmpty
            ? Column(
                children: [
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: (context, index) => HostedTripTile(index),
                    itemCount: hostedTrips.length,
                  ))
                ],
              )
              : const SizedBox()),
    );
  }

  HostedTripTile(index) {
    String len = hostedTrips[index].location.toString();
    String loc = len.substring(1, len.length - 1);
    var time =
        DateFormat('dd-MM-yy').format(hostedTrips[index].timestamp.toDate());
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: CustomColors.primaryColor, width: 3)),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                hostedTrips[index].title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              Text(
                (loc.length < 20)
                    ? "Locations: $loc"
                    : "Locations: ${loc.substring(0, 20)}",
                // overflow: TextOverflow.fade,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
              Text(
                "Start date: $time",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          Spacer(),
          GestureDetector(
            onTap: () => Navigator.pushNamed(
                context, HostedTRSelection.routeName,
                arguments: hostedTrips[index].tripId),
            child: Container(
              // color: Colors.black,
              width: 40,
              height: 90,
              decoration: BoxDecoration(
                  // color: Colors.black,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(8),
                      topRight: Radius.circular(8)),
                  border:
                      Border.all(color: CustomColors.primaryColor, width: 1)),
              child: Center(
                child: Icon(
                  Icons.chevron_right,
                  size: 30,
                  color: CustomColors.primaryColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchTripData() async {
    List hostings = widget.tripHostings;
    int len = hostings.length;
    var datalist = [];
    for (int i = len - 1; i >= 0; i--) {
      var documentSnapshot = await ff.doc(hostings[i].toString()).get();
      // datalist.add(documentSnapshot.data());
      var data = documentSnapshot.data();
      hostedTrips.add(TempTrip(
          tripId: data?['refId'],
          title: data?['title'],
          location: data?['locations'],
        timestamp: data?['startDate'],
      ));
    }
    setState(() {});
  }
}

class TempTrip {
  final String title, tripId;
  final Timestamp timestamp;
  final List<dynamic> location;

  const TempTrip(
      {required this.tripId,
      required this.title,
      required this.location,
      required this.timestamp});
}