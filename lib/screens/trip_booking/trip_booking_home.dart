import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/authentication/GoogleLogin.dart';
import 'package:hum_chale/authentication/Shared_pref.dart';
import 'package:hum_chale/models/trip.dart';
import 'package:hum_chale/screens/trip_booking/product_details_screen.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';

class TripBookingHome extends StatefulWidget {
  static var routeName = "trip-booking-home";
  const TripBookingHome({super.key});

  @override
  State<TripBookingHome> createState() => _TripBookingHomeState();
}

class _TripBookingHomeState extends State<TripBookingHome> {
  List<DocumentSnapshot> _allTrips = [];
  List<DocumentSnapshot> _filteredTrips = [];
  var _searchQuery = '';

  // void _runFilter(String enteredKeyword) {
  //   // List<DocumentSnapshot> results = [];
  //   if (enteredKeyword.isEmpty) {
  //     _filteredTrips = _allTrips;
  //     setState(() {});
  //   } else {
  //     // results = _allTrips
  //     //     .where((user) =>
  //     //         user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
  //     //     .toList();
  //   //     _filteredTrips = _allTrips.where((trip) {
  //   //       String title = trip['title'].toString().toLowerCase();
  //   //       return title.contains(enteredKeyword.toLowerCase());
  //   //     }).toList();
  //   //     if (_filteredTrips != _allTrips) {
  //   //       setState(() {});
  //   //     }
  //   //   }
  //   //   // print(_filteredTrips);
  //   // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const Gap(20),
              TextField(
                // onChanged: (value) => _runFilter(value),
                onChanged: (value) {
                  _searchQuery = value;
                  setState(() {});
                },
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(
                          color: CustomColors.primaryColor, width: 3),
                    ),
                    enabled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: CustomColors.primaryColor, width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: CustomColors.primaryColor, width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search)),
              ),
              const Gap(40),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("trips")
                      .where("startDate",
                          isGreaterThanOrEqualTo: Timestamp.now())
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        _allTrips = snapshot.data!.docs;
                        _filteredTrips = _runFilter1(_allTrips);
                        return SizedBox(
                            width: double.infinity,
                            height: 427,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              // itemCount: snapshot.data!.docs.length,
                              itemCount: _filteredTrips.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailsScreen(
                                                    trip: Trip.fromSnapshot(
                                                      // snapshot.data!.docs[index]
                                                      _filteredTrips[index],
                                                    ),
                                                  )));
                                    },
                                child: itemTile(index, _filteredTrips[index]),
                              ),
                            ));
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.hasError.toString()),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }
                    return const Padding(
                        padding: EdgeInsets.only(top: 200),
                        child: CircularProgressIndicator());
                  }),
            ],
          ),
        ),
      ),
    );
  }

  List<DocumentSnapshot> _runFilter1(List<DocumentSnapshot> trips) {
    final enteredKeyword = _searchQuery.toLowerCase();
    if (enteredKeyword.isEmpty) {
      return trips;
    } else {
      return trips.where((trip) {
        for (var location in trip['locations']) {
          if (location.toLowerCase().contains(_searchQuery.toLowerCase())) {
            return true;
          }
        }
        return false;
      }).toList();
      return trips.where((trip) {
        final title = trip['title'].toString().toLowerCase();
        return title.contains(enteredKeyword);
      }).toList();
    }
  }
}

Widget itemTile(int index, dynamic doc) {
  var date = doc['startDate'].toDate();
  return Container(
    width: 200.0,
    // padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
    margin: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.black38, spreadRadius: 1, blurRadius: 1)
        ],
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.black),
        color: Colors.grey.shade50),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // const Gap(2),
        Hero(
          tag: "hello$index",
          transitionOnUserGestures: true,
          child: ClipRRect(
              child: Container(
            // color: Colors.black,
            height: 350,
            width: 200,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.black45),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                topLeft: Radius.circular(8),
                bottomRight: Radius.circular(2),
                bottomLeft: Radius.circular(2),
              ),
              image: DecorationImage(
                image: CachedNetworkImageProvider(doc['imageUrl'].toString()),
                fit: BoxFit.cover,
              ),
            ),
          )),
        ),
        const Gap(5),
        Text(
          // doc['price'],
          "  ${doc['title']}",
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w800),
        ),
        Row(
          children: [
            Text(
              "  ${date.day} ${DateFormat.MMM().format(date)}",
              style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            Text(
              "${doc['price']} ₹",
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black54,
                  fontWeight: FontWeight.w600),
            ),
            const Gap(10)
          ],
        )
        // const Gap(10),
        // Text("15000",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w600,color: Colors.white),)
      ],
    ),
  );
}
