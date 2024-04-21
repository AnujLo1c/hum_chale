
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
// import 'package:hum_chale/models/TravelRoute.dart';
// import 'pahum_chale/models/TravelRoute.dart';
import 'package:hum_chale/screens/trip_hosting/trip_transit.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/widget/CustomAppBar.dart';
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
  TextEditingController textEditingControllerStart = TextEditingController();
  TextEditingController textEditingControllerDest = TextEditingController();
  TextEditingController textEditingControllerTime = TextEditingController();
  late DateTime? _selectedDate=null;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Gap(20),
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
            margin: EdgeInsets.only(bottom: 17),
            child: ElevatedButton(
              onPressed: (){
                widget.trip.setItinerary(itineraries);
                // var t=widget.trip.travelRoute;
                // print(t?.elementAt(0).start);
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
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
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
                      onTap: () {
                        _selectDate(context);
                      },
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
                        TravelRoute temp =  TravelRoute(
                            start: s, dest: d, time: t, date: _selectedDate);
                        itineraries!.add(temp);
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
      // print("sadfsadfg");
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

  Widget itineraryTile(int index) {
    TravelRoute r = itineraries!.elementAt(index);
    return Container(
        margin: EdgeInsets.only(right: 20,left: 20,top: 10,bottom: 10),
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 20),
        height: 70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            border: Border.all(width: 2, color: CustomColors.primaryColor)),
        child: Column(
          children: [
            Row(children: [
              Text(r.start.toString(),style: TextStyle(fontSize: 20),),
              Spacer(),
              Icon(Icons.arrow_right_alt),
              Spacer(),
              Text(r.dest.toString(),style: TextStyle(fontSize: 20)),
            ]),Gap(5),
            Row(
              children: [
                Text(DateFormat('yyyy-MM-dd').format(r.date!)),
    Spacer(),
    Text(r.time)
    // String formattedDate = DateFormat('yyyy-MM-dd').format(now);
              ],
            )
          ],
        )
    );
  }
}


