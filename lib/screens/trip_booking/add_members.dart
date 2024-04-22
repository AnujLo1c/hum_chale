import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/models/trip.dart';
import 'package:hum_chale/screens/custom_bottom_nav.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/widget/CustomAppBar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
class AddMembers extends StatefulWidget {
  static var routeName = "Add-members-screen";
  final TripJoinRequest tripReq;

  const AddMembers({super.key, required this.tripReq});

  @override
  State<AddMembers> createState() => _AddMembersState();
}

class _AddMembersState extends State<AddMembers> {
  List<Member> members=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final nameAndAge = widget.tripReq.name.split('#');
    members.add(
        Member(age: int.tryParse(nameAndAge[1]) ?? 0, name: nameAndAge[0]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [
          Gap(40),
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
              onPressed: () {
                List<String> outputList = [];
                for (var member in members) {
                  String output = '${member.name}#${member.age}';
                  outputList.add(output);
                }
                widget.tripReq.setMembers(outputList);
                //add this request to trip new field requests
                //add this to user trip history
                Navigator.popUntil(
                    context,
                    (route) =>
                        route.settings.name == CustomBottomNav.routeName);
              },
              style: ElevatedButton.styleFrom(
                elevation: 5,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                backgroundColor: CustomColors.primaryColor,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'Submit Interest',
                style: TextStyle(fontSize: 22),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddMember()
        ,child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  Widget memberTile(int index) {
    return Slidable(
      key: const ValueKey(0),
      startActionPane: ActionPane(
        motion: const ScrollMotion(),
        // dismissible: DismissiblePane(onDismissed: () {print("object");}),
        children:  [
          SlidableAction(
            onPressed: (context){
              members.removeAt(index);
              setState(() {
                
              });
            },
            borderRadius: BorderRadius.all(Radius.circular(5)),
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),

        ],
      ),
      child:  Container(
          margin: EdgeInsets.symmetric(vertical: 5,horizontal: 25),
          padding:EdgeInsets.symmetric(vertical: 5,horizontal: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8),),
                border: Border.all(width: 2,color: CustomColors.primaryColor)
          ),
          child: Row(
            children: [
              Text(members[index].name,style: TextStyle(fontSize: 18),),
              Spacer(),
              Text("Age: ${members[index].age.toString()}"),
            ],
          ),
        ),
    );
  }

  AddMember() {
        var fs=TextStyle(fontSize: 20,);
        TextEditingController tecName=TextEditingController();
        TextEditingController tecAge=TextEditingController();
        @override
    void dispose() {
      // Add code before the super
      super.dispose();
    }

    showDialog(context: context,
        builder: (context) => Dialog(
          child: Container(
            height: 200,
            width: 200,
          padding: EdgeInsets.symmetric(vertical: 15,horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            border: Border.all(color: CustomColors.primaryColor,width: 2)
          ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Name",style: fs,),
                    Spacer(),
                    SizedBox(
                      width: 160,
                      height: 40,
                      child: TextField(controller: tecName,
                        cursorHeight: 25,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 2)
                          )
                      ),),
                    )
                  ],
                ),
                Gap(10),
                Row(
                  children: [
                    Text("Age",style: fs,),
                    Gap(40),
                    SizedBox(
                      width: 50,
                      height: 40,
                      child: TextField(controller: tecAge,
                        cursorHeight: 25,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(5),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(width: 2)
                            )
                        ),),
                    )
                  ],
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width-50,
                  margin: EdgeInsets.only(bottom: 5,top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Member m=new Member(age: int.parse(tecAge.text), name: tecName.text);
                      members.add(m);
                      Navigator.pop(context);

                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
                      backgroundColor: CustomColors.primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Add Member',style: TextStyle(fontSize: 22),),
                  ),
                ),
              ],
            ),
          
          
          ),
        )
    );
  }
}

class Member{
  final int age;
 final String name;

  Member({required this.age, required this.name});
}
