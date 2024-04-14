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
        title: Text("To Do List", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),),
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
            Image(image: AssetImage("assets/images/todo.png")),
            Text("Empty To DO list", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w600),),
            Text("CLick the add button below to \nadd your first task", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),textAlign: TextAlign.center,)
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
