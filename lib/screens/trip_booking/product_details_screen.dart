import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hum_chale/models/trip.dart'; // Import the trip.dart file only once

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
  void _show(BuildContext ctx) {
    showModalBottomSheet(
      barrierColor: Colors.transparent,
        isDismissible: false,

        elevation: 10,
        backgroundColor: Colors.white,
        context: ctx,
        builder: (ctx) =>
          WillPopScope(
            onWillPop: () async{
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
              return false;
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 400,
              // color: Colors.white54,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))
              ),
              child: const Text('Breathe in... Breathe out......................'),
            ),
          ),
        // )
    )
    ;
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
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
