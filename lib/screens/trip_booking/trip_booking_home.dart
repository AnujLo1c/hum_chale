import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/models/trip.dart';
import 'package:hum_chale/screens/trip_booking/product_details_screen.dart';
import 'package:hum_chale/ui/CustomColors.dart';
class TripBookingHome extends StatefulWidget {
  static var routeName = "trip-booking-home";
  const TripBookingHome({super.key});

  @override
  State<TripBookingHome> createState() => _TripBookingHomeState();
}

class _TripBookingHomeState extends State<TripBookingHome> {
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "Banana", "age": 14},
    {"id": 9, "name": "Caversky", "age": 100},
    {"id": 10, "name": "Becky", "age": 32},
  ];

  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    _foundUsers = _allUsers;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              // height: 350,
              child: _foundUsers.isNotEmpty
                  ? SizedBox(
                width: double.infinity,
                    height: 400,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: (){
                          Trip t=new Trip(title: "Goa",price: "15000",imageurl: "assets/images/temptrip${index%2}.jpg",index :index%2);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(trip: t),));
                        },
                        child: itemTile(index),
                      ),
                    ),
                  )
                  : const Text(
                'No results found',
                style: TextStyle(fontSize: 24),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

Widget itemTile(int index){
  return Container(
    width: 200.0,
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
            color:Colors.black54,
          spreadRadius: 2,blurRadius: 2
        )
      ],
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.black),
      color: Colors.grey.shade400
    ),
child: Center(
  child: Column(
    children: [
      Gap(2),
      Hero(
        tag: "hello"+index.toString(),
        transitionOnUserGestures: true,
        child: ClipRRect(
          child: Container(
            // color: Colors.black,
            height: 339,
          width:195,
            decoration: BoxDecoration(
              // boxShadow: [
              //    BoxShadow(
              //      blurRadius: 2
              //    )
              // ],
              borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft: Radius.circular(8)),
              image: DecorationImage(
                image: AssetImage("assets/images/temptrip${index%2}.jpg"), // Set background image
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 20,left: 65),
              child: Text("Goa",style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w900,fontSize: 34),),
            )
          ),
        ),
      ),
      Gap(10),
      Text("15000₹",style: TextStyle(fontSize: 22,color: Colors.white),),
      // Gap(200),
      // Text("15000",style: TextStyle(fontSize: 28,fontWeight: FontWeight.w600,color: Colors.white),)
    ],
  ),
),
  );

}
