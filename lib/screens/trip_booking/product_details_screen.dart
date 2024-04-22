import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:hum_chale/models/trip.dart';

import 'package:hum_chale/screens/trip_booking/add_members.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/models/tuser.dart';
import 'package:hum_chale/firebase/user_firestore_storage.dart';

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
    showModalBottomSheet(
      barrierColor: Colors.transparent,
      isDismissible: false,
      elevation: 10,
      backgroundColor: Colors.white,
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
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Trip Details}',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),

              Text(widget.trip.title,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              Text('Date: ${widget.trip.title}'),
              Text('Price: ${widget.trip.price}'),
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
                        docId: widget.trip.refId!,
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
