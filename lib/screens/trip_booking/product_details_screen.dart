import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hum_chale/models/trip.dart';
import 'package:hum_chale/screens/custom_bottom_nav.dart';
import 'package:hum_chale/screens/trip_booking/add_members.dart';
import 'package:hum_chale/ui/CustomColors.dart'; // Import the trip.dart file only once

class ProductDetailsScreen extends StatefulWidget {
  static var routeName = "product-detail";
  final Trip trip;

  const ProductDetailsScreen({Key? key, required this.trip}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  Timer(Duration(milliseconds: 100),() => _show(context),);
  }
  // void _show(BuildContext ctx, Trip trip) {
  //   showModalBottomSheet(
  //
  //     barrierColor: Colors.transparent,
  //       isDismissible: false,
  //       elevation: 10,
  //       backgroundColor: Colors.white,
  //       context: ctx,
  //       builder: (ctx) =>
  //         WillPopScope(
  //           onWillPop: () async{
  //             Navigator.of(ctx).pop();
  //             Navigator.of(context).pop();
  //             return false;
  //           },
  //           child: Container(
  //             width: MediaQuery.of(context).size.width,
  //             height: 400,
  //             padding: EdgeInsets.symmetric(vertical: 20,horizontal: 20),
  //             // color: Colors.white54,
  //             // alignment: Alignment.center,
  //             decoration: BoxDecoration(
  //               border: Border.all(color: Colors.black),
  //               borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))
  //             ),
  //             child: const Text(),
  //           ),
  //         ),
  //       // )
  //   )
  //   ;
  // }
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
          height: 400,
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Trip Details',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 5),

              Text(widget.trip.title,style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              Text('Date: ${widget.trip.title}'),
              Text('Price: ${widget.trip.price}'),
              // Add more details as needed
              Spacer(),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width-50,
                margin: EdgeInsets.only(bottom: 17),
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, AddMembers.routeName),
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
                    height: 400,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.trip.imageurl),
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
