
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/authentication/GoogleLogin.dart';
import 'package:hum_chale/ui/CustomColors.dart';
class ACBooking extends StatelessWidget {
  static var routeName = "ac-booking";
  final List<IconData> lodging;
  const ACBooking({super.key, required this.lodging});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading:  IconButton(onPressed: () => Navigator.pop(context),icon:Icon(Icons.arrow_back_ios),color: CustomColors.primaryColor,),
          title: const Text("Lodging",style: TextStyle(fontSize: 28,color: CustomColors.primaryColor),),
        ),
        body: Column(
          children: [
            ElevatedButton(onPressed: ()=>GoogleLogin().logOutFromGoogle(context), child: Text("sdf")),
            Divider(color: CustomColors.primaryColor,),
            Gap(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                lodging.length>0?
                transitTile(lodging[0]):Container(),
                lodging.length>1?
                transitTile(lodging[1]):Container(width: 80,),
                lodging.length>2?
                transitTile(lodging[2]):Container(width: 80,),
              ],
            ),
            const Gap(15),
            Row(
              children: [
                const Gap(27),
                lodging.length>3?
                transitTile(lodging[3]):Container(),
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
