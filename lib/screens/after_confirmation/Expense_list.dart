import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/widget/custom_snackbar.dart';

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
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(
            color: CustomColors.primaryColor,
          ),
          Gap(100),
          Image(image: AssetImage("assets/images/expense.png")),
          Text(
            "Start noting expenses",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
              .customSnackbar(3, "Pending feature", "Feature coming soon.."));
        },
        backgroundColor: CustomColors.primaryColor,
        shape: const CircleBorder(),
        heroTag: null,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
