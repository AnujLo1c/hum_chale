import 'package:flutter/material.dart';
import 'package:hum_chale/ui/CustomColors.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
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
          "Todo List",
          style: TextStyle(fontSize: 28, color: CustomColors.primaryColor),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Divider(
            color: CustomColors.primaryColor,
          ),
          Image(image: AssetImage("assets/images/todo.png")),
          Text(
            "Empty To DO list",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),
          ),
          Text(
            "CLick the add button below to \nadd your first task",
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
