import 'package:flutter/material.dart';

import '../../ui/CustomColors.dart';

class packingList extends StatefulWidget {
  const packingList({super.key});

  @override
  State<packingList> createState() => _packingListState();
}

class _packingListState extends State<packingList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Packing List", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0), // Set the height of the bottom border
          child: Divider(color: Colors.black), // Add a Divider widget with a color
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage("assets/images/packing_list.png")),
            Text("Start Packing", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),),
            Text("All  trip member get there\nown packing list with the\nability to view others in\nthe  trip", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),textAlign: TextAlign.center,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add,color: Colors.white, size: 40,),
        backgroundColor: CustomColors.primaryColor,
        shape: CircleBorder(),
        heroTag: null,
      ),
    );
  }
}
