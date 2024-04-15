import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hum_chale/screens/trip_booking/explore.dart';

class EmailPassLogin{
  final _auth=FirebaseAuth.instance;
  userLogin(BuildContext context,String email,String password) async {
    try {

      var userInstance=await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      if(userInstance.additionalUserInfo!.isNewUser){

      }
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Explore()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0),
            )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0),
            )));
      }
    }
  }


  
}