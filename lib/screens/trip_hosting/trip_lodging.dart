import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/screens/custom_bottom_nav.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/widget/CustomAppBar.dart';
class TripLodging extends StatefulWidget {
  static var routeName = "trip-lodging";
  const TripLodging({super.key});

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
              Gap(20),
              Center(
                  child: Text(
                    "  Select Lodging details",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  )),
              Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  lodgingTile(Icons.home,0),
                  lodgingTile(Icons.house_outlined,1),
                  lodgingTile(Icons.meeting_room,2),
                ],
              ),

              Spacer(),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width-50,
                margin: EdgeInsets.only(bottom: 17),
                child: ElevatedButton(
                  onPressed: () => Navigator.popUntil(context, (route) => route.settings.name==CustomBottomNav.routeName),
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
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: lodging[i]==false?CustomColors.primaryColor:Colors.white70,
            borderRadius: BorderRadius.all(Radius.circular(15))),
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
