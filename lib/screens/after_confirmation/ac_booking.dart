
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
    int len = lodging.length;
    // print(lodging[1].toString());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
            color: CustomColors.primaryColor,
          ),
          title: const Text("Lodging",style: TextStyle(fontSize: 28,color: CustomColors.primaryColor),),
        ),
        body: Column(
          children: [
            const Divider(
              color: CustomColors.primaryColor,
            ),
            const Gap(40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                len > 0 ? transitTile(lodging[0]) : const Gap(1),
                len > 1 ? transitTile(lodging[1]) : const Gap(80),
                len > 2 ? transitTile(lodging[2]) : const Gap(80),
              ],
            ),
            const Gap(15),
            Row(
              children: [
                const Gap(27),
                len > 3 ? transitTile(lodging[3]) : const Gap(1),
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
      decoration: const BoxDecoration(
          color: CustomColors.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(15))),
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
