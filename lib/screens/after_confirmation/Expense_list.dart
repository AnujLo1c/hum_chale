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
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
          color: CustomColors.primaryColor,
        ),
        title: const Text(
          "Expanses",
          style: TextStyle(fontSize: 28, color: CustomColors.primaryColor),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Divider(
            color: CustomColors.primaryColor,
          ),
          Image(image: AssetImage("assets/images/expense.png")),
          Gap(50),
          Text(
            "No Personal trip\nExpenses",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          Text(
            "Expenses added here cannot\nbe seen by anyone else",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
            textAlign: TextAlign.center,
          )
        ],
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
