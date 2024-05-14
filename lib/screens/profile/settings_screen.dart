import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/firebase/user_firestore_storage.dart';
import 'package:hum_chale/screens/profile/profile_home.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/widget/CustomAppBar.dart';
import 'package:hum_chale/widget/custom_snackbar.dart';
import 'package:hum_chale/widget/loading-dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rive/math.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName = "settings";
  final dynamic data;

  const SettingsScreen({Key? key, required this.data
      // , this.refreshData
      })
      : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  File? pickedImage;

  @override
  Widget build(BuildContext context) {
    final Function() refreshData = widget.data["refreshData"];
    ;
    // print(widget.data["email"]);
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          text: "Settings",
        ),
        body: Center(
          child: SizedBox(
            width: size.width - 30,
            child: ListView(
              children: [
                const Gap(30),
                settingsTile("Modify Name.", Icons.abc, size, 1, context),
                // const Gap(12),
                // settingsTile(
                //     "Change Phone Number.", Icons.phone, size, 0, context),
                const Gap(12),
                settingsTile(
                    "Change Profile Picture.", Icons.person, size, 2, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  settingsTile(
      String s, IconData icon, Size size, int change, BuildContext context) {
    return GestureDetector(
      onTap: () {
        TextEditingController fn = TextEditingController();
        if (change == 1) {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                backgroundColor: Colors.white,
                child: SizedBox(
                  height: 200,
                  width: size.width - 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Gap(30),
                      SizedBox(
                          width: size.width - 120,
                          child: TextField(
                            controller: fn,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(width: 1)),
                                hintText: "New User Name",
                                filled: true,
                                fillColor: Colors.grey.shade100),
                          )),
                      Gap(10),
                      ElevatedButton(
                        onPressed: () {
                          UserFirestore().changeName(
                              fn.text, widget.data["email"], context);
                          widget.data["refreshData"]();
                          // fn.dispose();
                        },
                        child: Text(
                          "Change",
                          style: TextStyle(fontSize: 22),
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: CustomColors.primaryColor,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 90)),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          showdialog();
        }
      },
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
          height: 50,
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 2, color: Colors.black45)),
          child: Row(
            children: [
              Icon(
                icon,
                size: 26,
              ),
              Gap(10),
              Text(
                s,
                style: const TextStyle(fontSize: 20),
              ),
            ],
          )),
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
                // Navigator.pop(context);
              },
              leading: const Icon(Icons.camera),
              title: const Text("Camera"),
            ),
            ListTile(
              onTap: () {
                pickImage(ImageSource.gallery);
                // Navigator.pop(context);
              },
              leading: const Icon(Icons.image),
              title: const Text("Gallery"),
            ),
            ElevatedButton(
              onPressed: () {
                if (pickedImage != null) {
                  // print("object");
                  LoadingDialog().loadingDialog(context);
                  UserFirestore().changeProfile(
                      pickedImage, widget.data["email"], context);
                  Timer(Duration(seconds: 4), () {
                    widget.data["refreshData"]();
                  });
                } else {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar()
                      .customSnackbar(3, "No Image selected",
                          "Pls select a image to upload."));
                }
                pickedImage = null;
              },
              child: Text(
                "Change",
                style: TextStyle(fontSize: 18),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 90)),
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
      print(ex.toString());
    }
  }
}
