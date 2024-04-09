import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/widget/CustomAppBar.dart';

class TripItinerary extends StatefulWidget {
  static var routeName = "trip-itinerary";
  const TripItinerary({super.key});

  @override
  State<TripItinerary> createState() => _TripItineraryState();
}

class _TripItineraryState extends State<TripItinerary> {
  List<dynamic> itineraries = [];
  TextEditingController textEditingControllerStart = TextEditingController();
  TextEditingController textEditingControllerDest = TextEditingController();
  TextEditingController textEditingControllerTime = TextEditingController();
  // TextEditingController textEditingControllerdate=TextEditingController();
  late DateTime? _selectedDate = null;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(),
      body: ElevatedButton(
        child: Text("sadfas"),
        onPressed: () {
          Route t=itineraries.elementAt(0);
          print(t.start);
          // itineraries.clear();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddItem(),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                borderRadius: BorderRadius.all(Radius.circular(25))),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            height: 300,
            width: 355,
            child: Column(
              children: [
                InputField("Origin", textEditingControllerStart, 5),
                Gap(10),
                InputField("Stop", textEditingControllerDest, 20),
                Gap(20),
                InputField("Timing", textEditingControllerTime, 5),
                Gap(10),
                Row(
                  children: [
                    Text(
                      "Date",
                      style: TextStyle(fontSize: 20),
                    ),
                    Gap(35),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Text(
                        _selectedDate == null
                            ? 'No date selected'
                            : "${_selectedDate?.day}/${_selectedDate!.month}/${_selectedDate?.year}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Gap(10),
                ElevatedButton(
                    onPressed: () {
                      String s = textEditingControllerStart.text;
                      String d = textEditingControllerDest.text;
                      String t = textEditingControllerTime.text;
                      if (_selectedDate != null &&
                          s != "" &&
                          t != "" &&
                          d != "") {
                        Route temp = new Route(
                            start: s, dest: d, time: t, date: _selectedDate);
                        itineraries.add(temp);
                        setState(() {});
                        Navigator.pop(context);
                      } else {
                        print("Enter date");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(300, 50),
                        backgroundColor: CustomColors.primaryColor,
                        elevation: 5,
                        shadowColor: Colors.black45,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                    child: Text(
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
    // DateTime t=new DateTime.now();
    if (picked != null && picked != _selectedDate) {
      print("sadfsadfg");
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  InputField(String s, TextEditingController t, double size) {
    return Row(
      children: [
        Text(
          s,
          style: TextStyle(fontSize: 20),
        ),
        Gap(10 + size),
        SizedBox(
            height: 40,
            width: 170,
            child: TextField(
              controller: t,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              )),
            )),
      ],
    );
  }
}

class Route {
  final String start, dest, time;
  final DateTime? date;

  Route(
      {required this.start,
      required this.dest,
      required this.time,
      required this.date});
}
