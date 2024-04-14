import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/ui/CustomColors.dart';
class ACTransit extends StatelessWidget {
  static var routeName = "ac-transit";
  final List<IconData> transits;

  const ACTransit({super.key,required this.transits});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading:  IconButton(onPressed: () => Navigator.pop(context),icon:Icon(Icons.arrow_back_ios),color: CustomColors.primaryColor,),
          title: const Text("Transit",style: TextStyle(fontSize: 28,color: CustomColors.primaryColor),),
        ),
        body: Column(
          children: [
            Divider(color: CustomColors.primaryColor,),
            Gap(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                transits.length>0?
                transitTile(Icons.train):Container(),
                transits.length>1?
                transitTile(Icons.car_crash):Container(width: 80,),
                transits.length>2?
                transitTile(Icons.airplanemode_active_rounded):Container(width: 80,),
              ],
            ),
            const Gap(15),
            Row(
              children: [
                const Gap(27),
                transits.length>3?
                transitTile(Icons.bus_alert):Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
  transitTile(IconData icon) {
    return  Container(
        height: 80,
        width: 80,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: CustomColors.primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
            size: 50,
          ),
        ),

    );
  }

}
