import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hum_chale/authentication/Shared_pref.dart';
import 'package:hum_chale/firebase/user_firestore_storage.dart';
import 'package:hum_chale/models/tuser.dart';
import 'package:hum_chale/screens/trip_booking/explore.dart';
import 'package:hum_chale/authentication/email_verification_screen.dart';

class EmailPassLogin{
  final _auth=FirebaseAuth.instance;
  userLogin(BuildContext context,String email,String password) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password);
      SharedPref().LoginSP(email, password);
      Navigator.pushNamed(context, Explore.routeName);
    } on FirebaseAuthException catch (e) {
      // print(FirebaseAuth.instance.currentUser.);
      if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email and Password.",
              style: TextStyle(fontSize: 18.0),
            )));
      }
      // else if (e.code == 'wrong-password') {
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //       backgroundColor: Colors.orangeAccent,
      //       content: Text(
      //         "Wrong Password Provided by User",
      //         style: TextStyle(fontSize: 18.0),
      //       )));
      // }
      else{
        ScaffoldMessenger.of(context).showSnackBar( SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              e.message.toString(),
              style: const TextStyle(fontSize: 18.0),
            )));
      }
    }
    catch (e) {
      debugPrint(e.toString());
    }
  }

  registration(BuildContext context , Tuser user,String password, [File? pickedImage]) async {
    // if (password != null&& namecontroller.text!=""&& mailcontroller.text!="") {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: user.email, password: password);

        UserFirestore().createUserData(user,pickedImage);
      // UserFirestore().uploadUserData();
      Navigator.pushNamed(context, EmailVerificationScreen.routeName);
      } on FirebaseAuthException catch (e) {
        if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Account Already exists",
                style: TextStyle(fontSize: 18.0),
              )));
        }
         else if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "Password Provided is too Weak",
                style: TextStyle(fontSize: 18.0),
              )));
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar( SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                e.message.toString(),
                style: const TextStyle(fontSize: 18.0),
              )));
        }
      }
      catch (e) {
        debugPrint(e.toString());
      }

  }
  
}