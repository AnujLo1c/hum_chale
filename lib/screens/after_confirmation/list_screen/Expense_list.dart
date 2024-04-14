import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/ui/CustomColors.dart';



class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),),
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
            Image(image: AssetImage("assets/images/expense.png")),
            Gap(50),
            Text("No Personal trip\nExpenses", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600), textAlign: TextAlign.center,),
            Text("Expenses added here cannot\nbe seen by anyone else", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),textAlign: TextAlign.center,)
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
