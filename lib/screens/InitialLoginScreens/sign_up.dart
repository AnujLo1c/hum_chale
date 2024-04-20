
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
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_platform_interface/image_picker_platform_interface.dart';
import 'package:hum_chale/firebase/user_firestore_storage.dart';
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
  TextEditingController TECemailAddress = TextEditingController();
  //hintText
  final String HTfullName = "Full Name";
  final String HTage = "Age";
  final String HTphoneNo = "Phone No.";
  final String HTpassword = "Email Address";
  final String HTemailAddress = "Password";

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
                      child: pickedImage==null?const CircleAvatar(
                      radius: 60,
                        backgroundColor: CustomColors.primaryColor,
                        child: Icon(Icons.person,color: Colors.white,size: 70,),

                      ):
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: CustomColors.primaryColor,
                        backgroundImage: FileImage(pickedImage!),

                      )
                      ,
                    ),
                    const Gap(30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomTextField(
                            textEditingController: TECfullName,
                            hintText: HTfullName,
                            w: width - 20 - 60-20),
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
                    const Gap(20),
                    SignUpButton()
                  ],
                ),
              )),
    );
  }

  Widget SignUpButton() {
    return SizedBox(
      height: 60,
      width: width - 30,
      child: ElevatedButton(
        // onPressed: ()=>Navigator.pushNamed(context, Explore.routeName),
        onPressed: (){
          String password=TECemailAddress.text,email=TECpassword.text.trim();
          // debugPrint(   EmailValidator.validate(TECemailAddress.text).toString());
          if(
          EmailValidator.validate(email)&&
              TECemailAddress.text!="" && TECpassword.text!="" ){
            print("sign up");
            // UserFirestore().createUserData(email,pickedImage);
            EmailPassLogin().registration(context, email, password,pickedImage!);
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "Please fill in both the email and password fields correctly",
                  style: TextStyle(fontSize: 20.0),
                )
            ));
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
  showdialog(){
    return  showDialog(context: context,
      builder: (context) =>  AlertDialog(
        title: const Text("Pick Image from"),
        content:Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap:(){ pickImage(ImageSource.camera);
                Navigator.pop(context);
                },
              leading: const Icon(Icons.camera),
              title: const Text("Camera"),
            ),
            ListTile(
              onTap:(){ pickImage(ImageSource.gallery);
                Navigator.pop(context);},
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
}
catch (ex){
  print(ex.toString());
}
  }
}
