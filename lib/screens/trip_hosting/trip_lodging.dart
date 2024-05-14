import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/models/trip.dart';
import 'package:hum_chale/screens/custom_bottom_nav.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/widget/CustomAppBar.dart';
import 'package:hum_chale/firebase/trip_firestore_storage.dart';
import 'package:hum_chale/widget/custom_snackbar.dart';

class TripLodging extends StatefulWidget {
  static var routeName = "trip-lodging";
  final Trip trip;
  const TripLodging({super.key, required this.trip});

  @override
  State<TripLodging> createState() => _TripLodgingState();
}

class _TripLodgingState extends State<TripLodging> {
  List<bool> lodging = List.filled(4, false);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(),
          body: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
          const Gap(20),
          const Center(
              child: Text(
            "  Select Lodging details",
            style: TextStyle(
                color: Colors.black87,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              lodgingTile(Icons.home,0),
                  lodgingTile(Icons.house_outlined,1),
                  lodgingTile(Icons.meeting_room,2),
                ],
              ),

          const Spacer(),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width - 50,
            margin: const EdgeInsets.only(bottom: 17),
            child: ElevatedButton(
              onPressed: () {
                widget.trip.setLodgings(lodging);
                tripFirestore().createTrip(widget.trip);
                ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
                    .customSnackbar(
                        1, "Created successfully", "Your trip is hosted :)"));
                Navigator.popUntil(
                    context,
                    (route) =>
                        route.settings.name == CustomBottomNav.routeName);

                  },style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    backgroundColor: CustomColors.primaryColor,
                    foregroundColor: Colors.white,
                  ),
              child: const Text(
                'Finish',
                style: TextStyle(fontSize: 22),
              ),
            ),
              ),
          const Gap(5)
          // transitTile(Icons.bus_alert)
        ],
      ),
    ));
  }
  lodgingTile(IconData icon, int i) {
    return InkWell(
      onTap: (){
        lodging[i]=lodging[i]==false?true:false;
        setState(() {

        });
      },
      child: Container(
        height: 80,
        width: 80,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: lodging[i]==false?CustomColors.primaryColor:Colors.white70,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Center(
          child: Icon(
            icon,
            color: lodging[i]==false?Colors.white:CustomColors.primaryColor,
            size: 50,
          ),
        ),
      ),
    );
  }
}
