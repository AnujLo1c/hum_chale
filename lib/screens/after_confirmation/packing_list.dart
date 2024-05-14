import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/widget/custom_snackbar.dart';

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
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
          color: CustomColors.primaryColor,
        ),
        title: const Text(
          "Packing List",
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
          Image(image: AssetImage("assets/images/packing_list.png")),
          Text(
            "Start Packing",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
              .customSnackbar(3, "Pending feature", "Feature coming soon.."));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
        backgroundColor: CustomColors.primaryColor,
        shape: const CircleBorder(),
        heroTag: null,
      ),
    );
  }
}
