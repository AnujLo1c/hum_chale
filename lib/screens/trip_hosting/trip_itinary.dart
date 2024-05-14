
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// import 'package:hum_chale/models/TravelRoute.dart';
// import 'pahum_chale/models/TravelRoute.dart';
import 'package:hum_chale/screens/trip_hosting/trip_transit.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/widget/CustomAppBar.dart';
import 'package:hum_chale/widget/custom_snackbar.dart';
import 'package:intl/intl.dart';
import 'package:hum_chale/models/trip.dart';
class TripItinerary extends StatefulWidget {
  static var routeName = "trip-itinerary";
final Trip trip;
  const TripItinerary({super.key,required this.trip});
  @override
  State<TripItinerary> createState() => _TripItineraryState();
}
class _TripItineraryState extends State<TripItinerary> {

  List<TravelRoute>? itineraries =[];
  List<String> locationsList = [];
  TextEditingController textEditingControllerStart = TextEditingController();
  TextEditingController textEditingControllerDest = TextEditingController();
  TextEditingController textEditingControllerTime = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? selectedTime;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          const Gap(20),
          Expanded(
            child: ListView.builder(
              itemCount: itineraries!.length,
              itemBuilder: (context, index) {
                return itineraryTile(index);
              },
            ),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width-90,
            margin: const EdgeInsets.only(bottom: 17),
            child: ElevatedButton(
              onPressed: (){
                var w = widget.trip;
                w.setItinerary(itineraries);
                w.setLocations(locationsList);
                Navigator.pushNamed(context, TripTransit.routeName,arguments: widget.trip);
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddItem(),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: MyFloatingActionButtonLocation(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.end,
    ));
  }

  AddItem() {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                  color: CustomColors.primaryColor,
                  width: 2,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(25))),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            height: 300,
            width: 355,
            child: Column(
              children: [
                InputField("Origin", textEditingControllerStart, 5),
                const Gap(10),
                InputField("Stop", textEditingControllerDest, 20),
                const Gap(7),
                // InputField("Timing", textEditingControllerTime, 5),
                Row(
                  children: [
                    const Text(
                      "Timing",
                      style: TextStyle(fontSize: 20),
                    ),
                    const Gap(8),
                    ElevatedButton(
                        onPressed: () {
                          _selectTime(context);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.transparent,
                          foregroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: const BorderSide(
                                  color: Colors.black54, width: 1)),
                        ),
                        child: (selectedTime == null)
                            ? const Text(
                                "Set Time",
                              )
                            : Text(selectedTime!.format(context).toString()))
                  ],
                ),
                const Gap(5),
                Row(
                  children: [
                    const Text(
                      "Date",
                      style: TextStyle(fontSize: 20),
                    ),
                    const Gap(28),
                    GestureDetector(
                      onTap: () {
                        _selectDate(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 22),
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black87),
                            borderRadius: BorderRadius.circular(7)),
                        child: Text(
                          _selectedDate == null
                              ? 'No date selected'
                              : "${_selectedDate?.day}/${_selectedDate!.month}/${_selectedDate?.year}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                ElevatedButton(
                    onPressed: () {
                      String s = textEditingControllerStart.text;
                      String d = textEditingControllerDest.text;
                      if (_selectedDate != null &&
                          s != "" &&
                          selectedTime != null &&
                          _selectedDate != null &&
                          d != "") {
                        String? t = selectedTime?.format(context).toString();
                        TravelRoute temp =  TravelRoute(
                            start: s, dest: d, time: t!, date: _selectedDate);
                        itineraries!.add(temp);
                        locationsList.add(d.toLowerCase());
                        setState(() {});
                        Navigator.pop(context);
                        disp();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackbar().customSnackbar(
                                3, "Empty Field", 'Please fill all fields.'));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(300, 50),
                        backgroundColor: CustomColors.primaryColor,
                        elevation: 5,
                        shadowColor: Colors.black45,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    child: const Text(
                      "ADD",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.white),
                    )),
              ],
            )),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      Navigator.pop(context);
      AddItem();
    }
  }

  InputField(String s, TextEditingController t, double size) {
    return Row(
      children: [
        Text(
          s,
          style: const TextStyle(fontSize: 20),
        ),
        Gap(10 + size),
        SizedBox(
            height: 40,
            width: 170,
            child: TextField(
              cursorHeight: 25,
              textAlignVertical: TextAlignVertical.center,
              controller: t,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
            )),
      ],
    );
  }

  Widget itineraryTile(int index) {
    TravelRoute r = itineraries!.elementAt(index);
    return Container(
        margin: const EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        height: 70,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            border: Border.all(width: 2, color: CustomColors.primaryColor)),
        child: Column(
          children: [
            Row(children: [
              Text(
                r.start.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              const Spacer(),
              const Icon(Icons.arrow_right_alt),
              const Spacer(),
              Text(r.dest.toString(), style: const TextStyle(fontSize: 20)),
            ]),
            const Gap(5),
            Row(
              children: [
                Text(DateFormat('yyyy-MM-dd').format(r.date!)),
                const Spacer(),
                Text(r.time)
                // String formattedDate = DateFormat('yyyy-MM-dd').format(now);
              ],
            )
          ],
        )
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      print(picked.format(context).toString());

      setState(() {});
      Navigator.pop(context);
      AddItem();
    }
  }

  void disp() {
    selectedTime = null;
    _selectedDate = null;
    textEditingControllerStart.clear();
    textEditingControllerDest.clear();
  }
}

class MyFloatingActionButtonLocation extends FloatingActionButtonLocation {
  @override
  Offset getOffset(ScaffoldPrelayoutGeometry scaffoldGeometry) {
    // Define your custom offset here
    return Offset(scaffoldGeometry.scaffoldSize.width - 75,
        scaffoldGeometry.scaffoldSize.height - 130.0);
  }

  @override
  String toString() => 'custom location';
}
