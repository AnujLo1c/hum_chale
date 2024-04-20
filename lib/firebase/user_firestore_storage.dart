
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UserFirestore{
  uploadUserData(){
    String? email=FirebaseAuth.instance.currentUser?.email.toString();
    FirebaseFirestore.instance.collection("Users").doc(email).set(
      {"Name":"Anuj Lowanshi",
      "Age":"21",
      "Phone":"7000664670"
      },
    );
  }
  createUserData(String email,File? pickedImage) async {
    UploadTask uploadTask=FirebaseStorage.instance.ref("Profile-pic").child(email).putFile(pickedImage!);
    TaskSnapshot taskSnapshot=await uploadTask;
    String url=await taskSnapshot.ref.getDownloadURL();
    FirebaseFirestore.instance.collection("userData").doc(email).set({
      "Email":email,
      "ImageURL":url
    }).then((value){
      print(url);
    });

  }
}