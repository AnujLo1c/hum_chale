
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hum_chale/models/tuser.dart';
import 'package:hum_chale/widget/custom_snackbar.dart';

class UserFirestore{
var ff=FirebaseFirestore.instance;
var fs=FirebaseStorage.instance;
var fa=FirebaseAuth.instance;
  createUserData(Tuser user,File? pickedImage) async {
    UploadTask uploadTask=fs.ref("Profile-pic").child(user.email).putFile(pickedImage!);
    TaskSnapshot taskSnapshot=await uploadTask;
    String imageurl=await taskSnapshot.ref.getDownloadURL();
    user.url=imageurl;
    // fa.currentUser?.updatePhotoURL(imageurl);
    ff.collection("userData").doc(user.email).set({
      "Name":user.fullName,
      "Age":user.age,
      "Phone":user.phoneNo,
      "Email":user.email,
      "ImageURL":imageurl,
      "uToken": user.uToken,
      "tripHistory": [],
      "hostings": []
    }).then((value){
      print("upload done");
    });

  }

  Future<dynamic> fetchUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    // print(currentUser?.email);
  if (currentUser != null) {
    DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance.collection("userData").doc(currentUser.email).get();
    if (userDataSnapshot.exists) {
        // print("object");
        print(userDataSnapshot.data());
      return Future.delayed(const Duration(milliseconds: 100)).then((value) => userDataSnapshot.data());
    } else {
      print('User data does not exist');
      return;
    }
  }
}

  changeName(newName, uemail, context) {
    print(uemail);
    ff.collection("userData").doc(uemail).update({
      "Name": newName,
    }).then((value) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
          .customSnackbar(1, "Changed Successfully", "User Name changed.."));
    });
  }

  changeProfile(image, uemail, context) async {
    print("hello");
    UploadTask uploadTask = fs.ref("Profile-pic").child(uemail).putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String imageurl = await taskSnapshot.ref.getDownloadURL();
    ff.collection("userData").doc(uemail).update({
      "ImageURL": imageurl,
    }).then((value) {
      Navigator.pop(context);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
          .customSnackbar(
              1, "Changed Successfully", "User Profile is changed.."));
    });
  }
}