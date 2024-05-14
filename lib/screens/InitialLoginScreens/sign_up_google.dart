import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hum_chale/authentication/Shared_pref.dart';
import 'package:hum_chale/authentication/email_pass_login.dart';
import 'package:hum_chale/firebase/user_firestore_storage.dart';
import 'package:hum_chale/models/tuser.dart';
import 'package:hum_chale/screens/trip_booking/explore.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/ui/app_style.dart';
import 'package:hum_chale/widget/custom_snackbar.dart';
import 'package:hum_chale/widget/custom_text_field.dart';
import 'package:hum_chale/widget/loading-dialog.dart';
import 'package:image_picker/image_picker.dart';

class SignUpG extends StatefulWidget {
  static var routeName = "/sign-up-G";
  const SignUpG({super.key});

  @override
  State<SignUpG> createState() => _SignUpGState();
}

class _SignUpGState extends State<SignUpG> {
  //Controllers
  TextEditingController TECfullName = TextEditingController();
  TextEditingController TECage = TextEditingController();
  TextEditingController TECphoneNo = TextEditingController();

  //hintText
  final String HTfullName = "Full Name";
  final String HTage = "Age";
  final String HTphoneNo = "Phone No.";
  File? pickedImage;
  //width
  late double width;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: true,
      onPopInvoked: (onPop){
        FirebaseAuth.instance.currentUser?.delete();
        GoogleSignIn().signOut();
      },
      child: SafeArea(
            child: Scaffold(

              resizeToAvoidBottomInset: true,
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: const Color(0xFF4FC3DC),
                  title: const Text("Hum Chale"),
                  centerTitle: true,
                  titleTextStyle: AppStyles.titleStyle,
                ),
                body: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  // color: const Color(0xFF4FC3DC),
                  child: Column(
                    children: [
                      const Gap(30),
                  InkWell(
                    onTap: () => showdialog(),
                    child: pickedImage == null
                        ? const Column(
                            children: [
                              CircleAvatar(
                                radius: 60,
                                backgroundColor: CustomColors.primaryColor,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 70,
                                ),
                              ),
                              Gap(3),
                              Text("Select profile"),
                              Gap(10)
                            ],
                          )
                        : CircleAvatar(
                            radius: 60,
                            backgroundColor: CustomColors.primaryColor,
                            backgroundImage: FileImage(pickedImage!),
                          ),
                  ),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                          textEditingController: TECfullName,
                          hintText: HTfullName,
                          w: width - 20 - 60 - 20),
                      const Gap(5),
                      CustomTextField(
                          textEditingController: TECage,
                          hintText: HTage,
                          w: 55),
                    ],
                  ),
                  const Gap(10),
                      CustomTextField(
                          textEditingController: TECphoneNo,
                          hintText: HTphoneNo,
                          w: width - 20),
                      const Gap(240),
                      SignUpGButton()
                    ],
                  ),
                )),
      ),
    );
  }

  Widget SignUpGButton() {
    return SizedBox(
      height: 60,
      width: width - 30,
      child: ElevatedButton(
        onPressed: (){
          //null check inclusion pending
          if (HTage.isNotEmpty &&
              HTfullName.isNotEmpty &&
              HTphoneNo.isNotEmpty &&
              pickedImage != null) {
            // FirebaseAuth
            // showPhoneDialog(context);
            var email = FirebaseAuth.instance.currentUser?.email;
            if (email != null) {
              LoadingDialog().loadingDialog(context);
              Tuser user = Tuser(
                  fullName: TECfullName.text,
                  phoneNo: TECphoneNo.text,
                  email: email,
                  age: int.parse(TECage.text));
              UserFirestore().createUserData(user, pickedImage);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, Explore.routeName);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
                  .customSnackbar(
                      0, "Error", "Error while fatching user data"));
            }
            // Navigator.pushReplacementNamed(context, Explore.routeName);
          } else if (pickedImage != null) {
            showSnackBarMessage("Please fill all the details");
          } else {
            showSnackBarMessage("Please upload profile pic.");
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.primaryColor,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(10)),
            )),
        child: const Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 28),),
      ),
    );
  }

  showdialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Pick Image from"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () {
                pickImage(ImageSource.camera);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.camera),
              title: const Text("Camera"),
            ),
            ListTile(
              onTap: () {
                pickImage(ImageSource.gallery);
                Navigator.pop(context);
              },
              leading: const Icon(Icons.image),
              title: const Text("Gallery"),
            )
          ],
        ),
      ),
    );
  }

  pickImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      final tempImage = File(image.path);
      setState(() {
        pickedImage = tempImage;
      });
    } catch (ex) {
      ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackbar().customSnackbar(0, "Error", ex.toString()));
    }
  }

  showPhoneDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return const SizedBox(
          height: 200,
          child: Dialog(
            backgroundColor: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Gap(10),
                CircularProgressIndicator(
                  color: CustomColors.primaryColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showSnackBarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(
        //   content: Text(
        //     message,
        //     style: TextStyle(fontSize: 20.0),
        //   ),
        // ));
        CustomSnackbar().customSnackbar(3, "Empty Field", message));
  }
}
