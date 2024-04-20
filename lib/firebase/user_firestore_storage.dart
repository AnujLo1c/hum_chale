
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hum_chale/models/tuser.dart';

class UserFirestore{
var ff=FirebaseFirestore.instance;
var fs=FirebaseStorage.instance;
  createUserData(Tuser user,File? pickedImage) async {
    UploadTask uploadTask=fs.ref("Profile-pic").child(user.email).putFile(pickedImage!);
    TaskSnapshot taskSnapshot=await uploadTask;
    String imageurl=await taskSnapshot.ref.getDownloadURL();
    user.url=imageurl;
    ff.collection("userData").doc(user.email).set({
      "Name":user.fullName,
      "Age":user.age,
      "Phone":user.phoneNo,
      "Email":user.email,
      "ImageURL":imageurl
    }).then((value){
      print("upload done");
    });

  }
  fetchdata(String? doc)async{
    print("helap");
var data=ff.collection("userData").doc(doc).get();
print(data);
return  data;
  }
}