import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/authentication/email_pass_login.dart';
import 'package:hum_chale/firebase/user_firestore_storage.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/ui/app_style.dart';
import 'package:hum_chale/widget/custom_text_field.dart';
import 'package:hum_chale/widget/loading-dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:hum_chale/models/tuser.dart';

class SignUp extends StatefulWidget {
  static var routeName = "/sign-up";
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //Controllers
  TextEditingController TECfullName = TextEditingController();
  TextEditingController TECage = TextEditingController();
  TextEditingController TECphoneNo = TextEditingController();
  TextEditingController TECpassword = TextEditingController();
  TextEditingController TECConfirmpassword = TextEditingController();
  TextEditingController TECemailAddress = TextEditingController();
  //hintText
  final String HTfullName = "Full Name";
  final String HTage = "Age";
  final String HTphoneNo = "Phone No.";
  final String HTpassword = "Password";
  final String HTConfirmpassword = "Confirm Password";
  final String HTemailAddress = "Email Address";

  //width
  late double width;

  File? pickedImage;
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return SafeArea(
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
            padding: const EdgeInsets.symmetric(horizontal: 20),
            // color: const Color(0xFF4FC3DC),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Gap(40),
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
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                        textEditingController: TECfullName,
                        hintText: HTfullName,
                        w: width - 20 - 60 - 20),
                    const Gap(5),
                    CustomTextField(
                        textEditingController: TECage, hintText: HTage, w: 55),
                  ],
                ),
                const Gap(10),
                CustomTextField(
                    textEditingController: TECphoneNo,
                    hintText: HTphoneNo,
                    w: width - 20),
                const Gap(10),
                CustomTextField(
                  textEditingController: TECemailAddress,
                  hintText: HTemailAddress,
                  w: width - 20,
                ),
                const Gap(10),
                CustomTextField(
                  textEditingController: TECpassword,
                  hintText: HTpassword,
                  w: width - 20,
                ),
                const Gap(10),
                CustomTextField(
                  textEditingController: TECConfirmpassword,
                  hintText: HTConfirmpassword,
                  w: width - 20,
                ),
                const Gap(20),
                SignUpButton()
              ],
            ),
          )),
    );
  }

  void showSnackBarMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(fontSize: 20.0),
      ),
    ));
  }

  Widget SignUpButton() {
    return SizedBox(
      height: 60,
      width: width - 30,
      child: ElevatedButton(
        onPressed: () {
          String email = TECemailAddress.text.trim();
          // debugPrint(EmailValidator.validate(TECemailAddress.text).toString());
          // print(email);
          String pass = TECpassword.text, cpass = TECConfirmpassword.text;
          if (TECfullName.text.isEmpty) {
            showSnackBarMessage("Please enter your full name");
          } else if (TECage.text.isEmpty) {
            showSnackBarMessage("Please enter your age");
          } else if (TECphoneNo.text.isEmpty) {
            showSnackBarMessage("Please enter your phone number");
          } else if (TECemailAddress.text.isEmpty) {
            showSnackBarMessage("Please enter your email address");
          } else if (EmailValidator.validate(email) == false) {
            showSnackBarMessage("Please enter valid email address");
          } else if (pass.isEmpty) {
            showSnackBarMessage("Please enter your password");
          } else if (checkPasswordStrength(pass) == -1) {
            showSnackBarMessage("Password to weak.");
          } else if (cpass.isEmpty) {
            showSnackBarMessage("Please confirm your password");
          } else if (pass.compareTo(cpass) != 0) {
            showSnackBarMessage("Password and Confirm password does't match");
          } else if (pickedImage == null) {
            showSnackBarMessage("Please upload profile picture.");
          } else {
            Tuser user = Tuser(
                fullName: TECfullName.text,
                phoneNo: TECphoneNo.text,
                email: email,
                age: int.parse(TECage.text));
            // UserFirestore().createUserData(email,pickedImage);
            LoadingDialog().loadingDialog(context);
            EmailPassLogin().registration(context, user, email, pickedImage!);
          }
          print(EmailValidator.validate(email));
          // if(
          // EmailValidator.validate(email)&&
          //     TECemailAddress.text != "" &&
          //     TECpassword.text != "") {
          //   // print("sign up");
          //   Tuser user=Tuser(fullName: TECfullName.text, phoneNo: TECphoneNo.text, email: email, age: int.parse(TECage.text));
          //   // UserFirestore().createUserData(email,pickedImage);
          //   EmailPassLogin().registration(context, user, email, pickedImage!);
          // }
          // else{
          //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          //       content: Text(
          //     "Please fill all fields and profile correctly",
          //     style: TextStyle(fontSize: 20.0),
          //   )));
          // }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.primaryColor,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            )),
        child: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.white, fontSize: 28),
        ),
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
      print(ex.toString());
    }
  }

  checkPasswordStrength(String password) {
    if (password.length < 8) {
      return -1;
    }

    bool hasUpperCase = false;
    bool hasLowerCase = false;
    bool hasDigit = false;
    bool hasSpecialChar = false;

    for (int i = 0; i < password.length; i++) {
      String char = password[i];
      if (char.toUpperCase() != char.toLowerCase()) {
        // Character is a letter
        if (char == char.toUpperCase()) {
          hasUpperCase = true;
        } else {
          hasLowerCase = true;
        }
      } else if (char.contains(RegExp(r'\d'))) {
        // Character is a digit
        hasDigit = true;
      } else {
        // Character is a special character
        hasSpecialChar = true;
      }
    }

    if (hasUpperCase && hasLowerCase && hasDigit && hasSpecialChar) {
      return 1;
    } else if ((hasUpperCase || hasLowerCase) && hasDigit) {
      return 0;
    } else {
      return -1;
    }
  }
}
