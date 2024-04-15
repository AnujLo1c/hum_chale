import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/screens/trip_booking/explore.dart';
import 'package:hum_chale/ui/app_style.dart';
import 'package:hum_chale/widget/custom_text_field.dart';

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
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xFF4FC3DC),
              title: const Text("Hum Chale"),
              centerTitle: true,
              titleTextStyle: AppStyles.titleStyle,
            ),
            body: Container(
              color: const Color(0xFF4FC3DC),
              child: Column(
                children: [
                  const Gap(30),
                  Center(
                    child: Container(
                      height: 200,
                      width: 260,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: ClipOval(
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child:
                              Image.asset("assets/images/sign-up-screen.jpg"),
                        ),
                      ),
                    ),
                  ),
                  const Gap(30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextField(
                          textEditingController: TECfullName,
                          hintText: HTfullName,
                          w: width - 20 - 60),
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
            )));
  }

  Widget SignUpButton() {
    return SizedBox(
      height: 60,
      width: width - 30,
      child: ElevatedButton(
        onPressed: ()=>Navigator.pushNamed(context, Explore.routeName),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey,
            elevation: 10,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(10)),
            )),
        child: const Text("Sign Up",style: TextStyle(fontSize: 22),),
      ),
    );
  }
}
