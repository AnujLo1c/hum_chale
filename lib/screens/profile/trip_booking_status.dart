import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/models/trip.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/widget/CustomAppBar.dart';

class TripBookingStatus extends StatefulWidget {
  static var routeName = "booking-updates";
  final List<dynamic> tripBookingStatus;

  const TripBookingStatus({super.key, required this.tripBookingStatus});

  @override
  State<TripBookingStatus> createState() => _TripBookingStatusState();
}

class _TripBookingStatusState extends State<TripBookingStatus> {
  List<TripJoinRequest> requests = [];
  List<String> titleList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(text: "Booking Updates"),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) => tripStatusTile(index),
            ),
          ),
        ],
      ),
    ));
  }

  Future<void> fetchData() async {
    var currentUser = FirebaseAuth.instance.currentUser;
    var firestore = FirebaseFirestore.instance;
    List<String> tripIds = widget.tripBookingStatus.cast<String>();
    print(tripIds);
    for (var tripId in tripIds) {
      var tripData = await firestore.collection("trips").doc(tripId).get();
      var requestsData = tripData.data()?['requests'];
      if (requestsData != null && requestsData.isNotEmpty) {
        var firstRequestData = requestsData[0];
        if (firstRequestData['email'] == currentUser?.email) {
          var request = TripJoinRequest(
            phone: firstRequestData['phone'],
            docId: firstRequestData['docId'],
            email: firstRequestData['email'],
            name: firstRequestData['name'],
            members: firstRequestData['members'] != null
                ? List<String>.from(firstRequestData['members'])
                : null,
          );
          setState(() {
            titleList.add(tripData['title']);
            requests.add(request);
          });
          print(requests);
        } else {
          print("Email does not match for trip ID: $tripId");
        }
      } else {
        print("No requests found for trip ID: $tripId");
      }
    }
  }

  tripStatusTile(int index) {
    TripJoinRequest tjr = requests[0];

    print("here${requests[0].members}");
    return Container(
      // height: 160,
      width: 400,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.primaryColor, width: 2),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            titleList[index],
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "No. of Members :",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
              ),
              Container(
                margin: EdgeInsets.all(4),
                padding: EdgeInsets.all(4),
                width: 25,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(4)),
                child: Center(child: Text(tjr.members!.length.toString())),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Status :",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
              ),
              Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(4),
                  width: 95,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(4)),
                  child: Center(
                      child: Text(
                    tripStatus(tjr.status),
                    style: TextStyle(fontSize: 16),
                  ))),
            ],
          )
        ],
      ),
    );
  }

  String tripStatus(String? status) {
    if (status != null) {
      switch (status) {
        case 'P':
          return "Pending";
        case 'C':
          return "Confirmed";
        case 'R':
          return "Rejected";
        case 'A':
          return "Approved";
        case 'F':
          return "Finished";
        default:
          return "Error";
      }
    }
    return "p";
  }
}
