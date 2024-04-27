import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/models/trip.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/widget/CustomAppBar.dart';
import 'package:intl/intl.dart';

class TripHistoryScreen extends StatefulWidget {
  static String routeName = "trip-history";
  final List<dynamic> tripHistoryList;

  const TripHistoryScreen({super.key, required this.tripHistoryList});

  @override
  State<TripHistoryScreen> createState() => _TripHistoryState();
}

class _TripHistoryState extends State<TripHistoryScreen> {
  late List<TripHistory> triphistorylist;

  @override
  Widget build(BuildContext context) {
    // List<TripHistory>? triphistorylist =
    //     widget.tripHistoryList.cast<TripHistory>();
    // List<dynamic> triphistorylist = widget.tripHistoryList;
    triphistorylist = widget.tripHistoryList
        .map<TripHistory>((map) => TripHistory(
              docId: map['docId'],
              status: map['status'],
              startDate: map['startDate'],
              membersCount: map['membersCount'],
              user: map['user'],
              title: map['title'],
            ))
        .toList();
    return SafeArea(
        child: Scaffold(
            appBar: CustomAppBar(text: "Trip History"),
            body: Column(
              children: [
                Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      color: Theme.of(context).primaryColor,
                      child: Center(
                          child: Text(
                        triphistorylist.length.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w900),
                      )),
                    ),
                    Gap(20),
                    Text(
                      "Trips Completed",
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                    )
                  ],
                ),
                Gap(15),
                Expanded(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    return hitoryTile(index);
                  },
                  itemCount: triphistorylist.length,
                )),
              ],
            )));
  }

  Widget hitoryTile(int index) {
    return Container(
      height: 130,
      width: 300,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(width: 2, color: CustomColors.primaryColor)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            triphistorylist[index].title,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your Companions Count:",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
              Text(triphistorylist[index].membersCount.toString())
            ],
          ),
          Gap(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Trip Date: ",
                style: TextStyle(fontSize: 18),
              ),
              Container(
                height: 35,
                width: 90,
                decoration: BoxDecoration(
                    color: CustomColors.primaryColor,
                    borderRadius: BorderRadius.circular(6)),
                child: Center(
                  child: Text(
                    DateFormat('dd-MM-yyyy')
                        .format(triphistorylist[index].startDate.toDate())
                        .toString(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Gap(5),
              Container(
                height: 35,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border:
                        Border.all(color: CustomColors.primaryColor, width: 2)),
                child: Center(
                  child: Text(tripStatus(triphistorylist[index].status)),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  String tripStatus(String? status) {
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
}
