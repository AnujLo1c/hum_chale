import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/widget/CustomAppBar.dart';
import 'trip_lodging.dart';
class TripTransit extends StatefulWidget {
  static var routeName = "trip-transit";
  const TripTransit({super.key});

  @override
  State<TripTransit> createState() => _TripTransitState();
}

class _TripTransitState extends State<TripTransit> {
  List<bool> transit = List.filled(5, false);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Gap(20),
          Center(
              child: Text(
            "Select Transit",
            style: TextStyle(
                color: Colors.black87,
                fontSize: 22,
                fontWeight: FontWeight.bold),
          )),
          Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              transitTile(Icons.train,0),
              transitTile(Icons.car_crash,1),
              transitTile(Icons.airplanemode_active_rounded,2),
            ],
          ),
          Gap(15),
          Row(
            children: [
          Gap(20),
              transitTile(Icons.bus_alert,3),
            ],
          ),
          Spacer(),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width-50,
            margin: EdgeInsets.only(bottom: 17),
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, TripLodging.routeName),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                backgroundColor: CustomColors.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Next',style: TextStyle(fontSize: 22),),
            ),
          ),
          Gap(5)
          // transitTile(Icons.bus_alert)
        ],
      ),
    ));
  }

  transitTile(IconData icon, int i) {
    return InkWell(
      onTap: (){
        transit[i]=transit[i]==false?true:false;
        setState(() {

        });
      },
      child: Container(
        height: 80,
        width: 80,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: transit[i]==false?CustomColors.primaryColor:Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Center(
          child: Icon(
            icon,
            color: transit[i]==false?Colors.white:CustomColors.primaryColor,
            size: 50,
          ),
        ),
      ),
    );
  }
}
