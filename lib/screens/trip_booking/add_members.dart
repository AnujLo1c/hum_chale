import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/widget/CustomAppBar.dart';
class AddMembers extends StatefulWidget {
  static var routeName = "Add-members-screen";
  const AddMembers({super.key});

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  List<dynamic> members=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Gap(20),
          Expanded(
            child: ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                return memberTile(index);
              },
            ),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width-50,
            margin: EdgeInsets.only(bottom: 17),
            child: ElevatedButton(
              // onPressed: () => Navigator.pushNamed(context, TripTransit.routeName),
              onPressed: (){},
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                backgroundColor: CustomColors.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text('Submit Interest',style: TextStyle(fontSize: 22),),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){}// => AddItem()
        ,child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  Widget memberTile(int index) {
    return Container();
  }
}
