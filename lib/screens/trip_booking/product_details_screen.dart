import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:hum_chale/models/trip.dart';

import 'package:hum_chale/screens/trip_booking/add_members.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/models/tuser.dart';
import 'package:hum_chale/firebase/user_firestore_storage.dart';
import 'package:intl/intl.dart';

class ProductDetailsScreen extends StatefulWidget {
  static var routeName = "product-detail";
  final Trip trip;

  const ProductDetailsScreen({Key? key, required this.trip}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  static Tuser? user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  Timer(const Duration(milliseconds: 100),() => _show(context),);
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      dynamic temp = await UserFirestore().fetchUserData();
      // print(temp);

      setState(() {
        user = Tuser(
            fullName: temp['Name'],
            phoneNo: temp['Phone'],
            email: temp['Email'],
            age: temp['Age']);
      });
      // print(user?.phoneNo);
    } catch (error) {
      print('Error fetching user data: $error');
      return null;
    }
  }

  void _show(BuildContext ctx) {
    var trip = widget.trip;
    String startDate = DateFormat.yMMMMd().format(trip.startDate);
    String endDate = DateFormat.yMMMMd().format(trip.endDate);
    var sh = const TextStyle(
        fontWeight: FontWeight.w700, fontSize: 20, color: Colors.black54);
    var sd = const TextStyle(
        fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black45);
    String locations = trip.locations.toString();
    showModalBottomSheet(
      barrierColor: Colors.transparent,
      isDismissible: false,
      elevation: 10,
      // backgroundColor: Colors.white70.withOpacity(1),
      context: ctx,
      builder: (ctx) => WillPopScope(
        onWillPop: () async {
          Navigator.of(ctx).pop();
          Navigator.of(context).pop();
          return false;
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/2,
          padding:
              const EdgeInsets.only(left: 30, top: 30, bottom: 10, right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey, width: 2),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                trip.title,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(15),

              // Text(widget.trip.title,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Start Date:',
                        style: sd,
                      ),
                      Text(
                        '  End Date:',
                        style: sd,
                      ),
                      Text(
                        'Pick-up-point:',
                        style: sd,
                      ),
                      Text(
                        'Locations:',
                        style: sd,
                      ),
                    ],
                  ),
                  Gap(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        startDate,
                        style: sh,
                      ),
                      Text(
                        endDate,
                        style: sh,
                      ),
                      Text(
                        trip.pickUpPoint,
                        style: sh,
                      ),
                      Text(
                        locations.substring(1, locations.length - 1),
                        style: sh,
                      ),
                    ],
                  ),
                  Gap(20)
                ],
              ),
              Gap(5),
              Text(
                "Activities  ",
                style: sh,
              ),
              Text(
                trip.activities,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black54),
              ),
              // Add more details as needed
              const Spacer(),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width-50,
                margin: const EdgeInsets.only(bottom: 17),
                child: ElevatedButton(
                  onPressed: () {
                    TripJoinRequest req = TripJoinRequest(
                        phone: user!.phoneNo,
                        docId: trip.refId!,
                        email: user!.email,
                        name: "${user!.fullName}#${user!.age}");
                    // print(req);
                    Navigator.pushNamed(context, AddMembers.routeName,
                        arguments: req);
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                    backgroundColor: CustomColors.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Next',style: TextStyle(fontSize: 22),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black26,
          body: Column(

            children: [
              Hero(
                transitionOnUserGestures: true,
                tag: "hello${widget.trip.index}",
                child: ClipRRect(
                  child: Container(
                  height: 480,
                  width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(widget.trip.imageurl),
                        fit: BoxFit.fill,
                      ),
                    ),

                  ),
                ),
              ),

            ],
          ),
        ),

    );
  }

}
