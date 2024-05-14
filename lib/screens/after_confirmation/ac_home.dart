
import 'package:cloud_firestore/cloud_firestore.dart';

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
import 'package:intl/intl.dart';

class Achome extends StatelessWidget {
  static var routeName = "ac-home";
  final String docId;

  Achome({super.key, required this.docId});

  ///memebers not now
  final List tempMember = ["Anuj Lowanshi", "Nandini Dhote"];
  final List<IconData> lodgingIcons = [];
  final List<IconData> transitIcons = [];

  @override

  Widget build(BuildContext context) {
precacheImage(const AssetImage("assets/images/aAfter-confirm.jpeg"), context);
    final Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("trips")
                .doc(docId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // return a loading indicator if the connection is still active
                return const SizedBox(
                    height: 100,
                    width: 100,
                    child: Center(child: CircularProgressIndicator()));
              } else if (snapshot.hasError) {
                // return an error widget if there's an error
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                // return an empty widget if there's no data
                return const Text('Something wrong');
              } else {
                var tripData = snapshot.data;
                // render UI using tripData
                List<dynamic> routeList = tripData?["travelRoute"];
                List<TravelRoute> tripRoutes = [];
                fetchLodgings(tripData?["lodgings"], tripData?["transits"]);
                routeList.forEach((data) {
                  DateTime date = (data['date'] as Timestamp).toDate();
                  String start = data['start'];
                  String time = data['time'];
                  String dest = data['dest'];

                  tripRoutes.add(TravelRoute(
                      date: date, start: start, time: time, dest: dest));
                });
                var sdate = tripData?["startDate"].toDate();
                String sd = DateFormat.yMMMMd().format(sdate);
                return Column(
                  children: [
                    Container(
                      height: size.height / 2,
                      width: size.width,
                      // color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15)),
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/aAfter-confirm.jpeg"),
                              fit: BoxFit.fill)),
                      child: GestureDetector(
                        onTap: () => membersInfo(context),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  tripData?["title"],
                                  style: const TextStyle(
                                      letterSpacing: 1,
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                                // IconButton(padding: EdgeInsets.all(5),,icon: Icon(Icons.home), onPressed: () {  },)

                                const Spacer(),
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(15))),
                                  child: InkWell(
                                      onTap: () => Navigator.popUntil(
                                          context,
                                          (route) =>
                                              route.settings.name ==
                                              CustomBottomNav.routeName),
                                      child: const Icon(
                                        color: Colors.black54,
                                        Icons.home_outlined,
                                        size: 36,
                                      )),
                                )
                              ],
                            ),
                            const Gap(3),
                            Text(
                              sd,
                              style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black45),
                            ),
                            const Spacer(),
                            Center(
                              child: Container(
                                width: size.width - 120,
                                height: 60,
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.2),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                child: Row(
                                  children: [
                                    const Gap(10),
                                    Container(
                                        height: 40,
                                        width: 40,
                                        margin: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(.8),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(30))),
                                        child: const Icon(
                                          Icons.person_outline_rounded,
                                          size: 30,
                                        )),
                                    const Spacer(),
                                    const Text(
                                      "Members",
                                      style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black54),
                                    ),
                                    const Gap(20)
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
                        ItemTile(Icons.mode_of_travel, "Itinerary",
                            ACItinerary(itineraries: tripRoutes), context),
                        ItemTile(Icons.luggage, "Packing List",
                            const packingList(), context),
                        ItemTile(Icons.list_alt, "To-do", const ToDo(), context)
                      ],
                    ),
                    const Gap(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ItemTile(Icons.wallet, "Expenses", const ExpenseList(),
                            context),
                        ItemTile(Icons.house, "Lodging",
                            ACBooking(lodging: lodgingIcons), context),
                        ItemTile(Icons.airplanemode_active_rounded, "Transit",
                            ACTransit(transits: transitIcons), context)
                      ],
                    ),
                  ],
                );
              }
            }),
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
            child: const Text(
              "Coming soon..",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            )
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     SizedBox(
            //       height: 200,
            //       child: ListView.builder(
            //         itemCount: tempMember.length,
            //         itemBuilder: (context, index) => membertile(index),
            //       ),
            //     ),
            //   ],
            // ),
            ),
      ),
    );
  }

//   membertile(int index) {
// return Container(
//   margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
//   padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
//   decoration: BoxDecoration(
//     borderRadius: const BorderRadius.all(Radius.circular(10),)
//         ,color: Colors.grey.shade300,
//       border: Border.all(color: Colors.black54,width: 3)
//   ),
//   // child: RichText(tempMember[index],style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
// child: RichText(text: TextSpan(text:tempMember[index],style: const TextStyle(letterSpacing: 2,fontWeight: FontWeight.w700,fontSize: 20,color: Colors.black87),
// children: [const TextSpan(text: "\nAge: 21",style: TextStyle(letterSpacing:1,fontSize: 18,color: Colors.black54))]
// )),
// );
//   }

  void fetchLodgings(tripLodging, tripTransit) {
    List<IconData> blist = [
      Icons.home,
      Icons.house_siding_outlined,
      Icons.house_siding_outlined,
      Icons.hotel_outlined
    ];
    List<IconData> tlist = [
      Icons.bus_alert,
      Icons.fire_truck_sharp,
      Icons.cyclone,
      Icons.bike_scooter,
      Icons.local_shipping_outlined
    ];
    for (int i = 0; i < tripLodging.length; i++) {
      if (tripLodging[i] == true) {
        lodgingIcons.add(blist[i]);
      }
    }
    for (int i = 0; i < tripTransit.length; i++) {
      if (tripTransit[i] == true) {
        transitIcons.add(tlist[i]);
      }
    }
  }
}