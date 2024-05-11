import 'dart:io';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as Flutter;
import 'package:flutter/painting.dart';
import 'package:gap/gap.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:hum_chale/models/trip.dart';
import 'package:hum_chale/screens/trip_hosting/trip_itinary.dart';
import 'package:hum_chale/ui/CustomColors.dart';

import 'package:hum_chale/widget/CustomButton.dart';
import 'package:hum_chale/widget/Custom_text_field_2.dart';
import 'package:hum_chale/screens/trip_hosting/trip_itinary.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class TripHostingHome extends StatefulWidget {
  static var routeName= "trip-hosting-home";

   TripHostingHome({super.key});

  @override
  State<TripHostingHome> createState() => _TripHostingHomeState();
}

class _TripHostingHomeState extends State<TripHostingHome> {
  dynamic file = null;

  final TextEditingController TECtitle = TextEditingController();

  final TextEditingController TECpickUpPoint = TextEditingController();

  final TextEditingController TECprice = TextEditingController();

  final TextEditingController TECactivities = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;
  String? starttext;
  String? endtext;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(5),
            Align(
                alignment: AlignmentDirectional.topStart,
                child: Text(
                  "Trip Hosting",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 34,
                      color: Theme.of(context).primaryColor),
                )),
            const Gap(20),
            CustomTextField2(
              textEditingController: TECtitle,
              hintText: 'Trip Title',
              w: 300,
            ),
            const Gap(10),
            CustomTextField2(
              textEditingController: TECpickUpPoint,
              hintText: 'Pick up Point',
              w: 200,
            ),
            const Gap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Gap(2),
                // const Text(
                //   "Price",
                //   style: TextStyle(
                //       fontSize: 28,
                //       color: Colors.black,
                //       fontWeight: FontWeight.w600),
                // ),
                // const Gap(10),
                CustomTextField2(
                    textEditingController: TECprice,
                    hintText: "Cost/Person",
                    w: 140,
                    size: size.width / 2 - 100),
                const Spacer(),
                ElevatedButton(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(17),
                        foregroundColor: file == null
                            ? CustomColors.primaryColor
                            : Colors.white,
                        backgroundColor: file == null
                            ? Colors.white
                            : Colors.greenAccent.shade200,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                                width: 2, color: CustomColors.primaryColor))),
                    child: file == null
                        ? const Text("Select Image")
                        : const Text("Change Image")),
                // const Gap(20)
              ],
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: GradientBoxBorder(
                      width: 2,
                      gradient: Flutter.LinearGradient(colors: [
                        Colors.blueAccent,
                        Colors.blue,
                        Colors.lightBlue,
                        Colors.lightBlueAccent
                      ]),
                    ),
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        _startDateGet(context);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black87),
                      child: starttext == null
                          ? const Text("Select Start Date")
                          : Text(starttext!.substring(0, 10))),
                ),
                Spacer(),
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: GradientBoxBorder(
                      width: 2,
                      gradient: Flutter.LinearGradient(colors: [
                        Colors.blueAccent,
                        Colors.blue,
                        Colors.lightBlue,
                        Colors.lightBlueAccent
                      ]),
                    ),
                  ),
                  child: ElevatedButton(
                      onPressed: () {
                        _endDateGet(context);
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          foregroundColor: Colors.black87,
                          backgroundColor: Colors.white),
                      child: endtext == null
                          ? const Text("Select End Date ")
                          : Text(endtext!.substring(0, 10))),
                )
              ],
            ),
            const Gap(15),
            CustomTextField2(
                textEditingController: TECactivities,
                hintText: "Activities included",
                w: 200,
                height: 5),
            const Gap(30),
            CustomButton(
              onTap: () {
                if (TECtitle.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 1000),
                      content: Text('Please fill title field'),
                    ),
                  );
                } else if (TECpickUpPoint.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 1000),
                      content: Text('Please fill pick up point Location'),
                    ),
                  );
                } else if (TECprice.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 1000),
                      content: Text('Please set Trip price.'),
                    ),
                  );
                } else if (TECactivities.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please fill activities field.'),
                    ),
                  );
                } else if (file == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 1000),
                      content: Text('Please select a trip Picture'),
                    ),
                  );
                } else if (_startDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 1000),
                      content: Text('Please select start date'),
                    ),
                  );
                } else if (_endDate == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(milliseconds: 1000),
                      content: Text('Please select end date'),
                    ),
                  );
                } else {
                  Trip trip = Trip(
                      pickedImage: file,
                      startDate: _startDate!,
                      endDate: _endDate!,
                      host: FirebaseAuth.instance.currentUser!.email,
                      activities: TECactivities.text,
                      pickUpPoint: TECpickUpPoint.text,
                      title: TECtitle.text,
                      price: TECprice.text,
                      imageurl: "my trip image",
                      index: 99);
                  Navigator.pushNamed(context, TripItinerary.routeName,
                      arguments: trip);
                }
              },
              text: "Next",
            )
          ],
        ),
      ),
    );
  }

  pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return -1;
      final tempImage = File(image.path);
      file = tempImage;
      setState(() {});
    } catch (ex) {
      print(ex.toString());
      return -1;
    }
  }

  Future<void> _startDateGet(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null) {
      if (_endDate == null || picked.isBefore(_endDate!)) {
        setState(() {
          _startDate = picked;
          starttext = _startDate.toString();
        });
      } else {
        print("Start date cannot be after end date");
      }
    }
  }

  Future<void> _endDateGet(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (picked != null) {
      if (_startDate == null ||
          picked.isAfter(_startDate!) ||
          picked.isAtSameMomentAs(_startDate!)) {
        setState(() {
          _endDate = picked;
          endtext = _endDate.toString();
        });
      } else {
        print("End date cannot be before start date");
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}