import 'package:gap/gap.dart';
import 'package:hum_chale/screens/InitialLoginScreens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/widget/CustomAppBar.dart';

class ForgotPassword extends StatefulWidget {
  static var routeName="forgot-password";

  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email = "";
  TextEditingController mailcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Password Reset Email has been sent !",
            style: TextStyle(fontSize: 20.0),
          )));
    } on FirebaseAuthException catch (e) {
      if (e.code == "user-not-found") {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "No user found for that email.",
              style: TextStyle(fontSize: 20.0),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40.0,
            ),
            Container(
              alignment: Alignment.topCenter,
              child: const Text(
                "Password Recovery",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Gap(20),
            const Text(
              "   Enter your mail",
              style: TextStyle(
                  color: Colors.black45,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            Gap(5),
            Expanded(
                child: Form(
                    key: _formkey,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: ListView(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 10.0),
                            decoration: BoxDecoration(
                              border:
                              Border.all(color: CustomColors.primaryColor, width: 2.0),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter Email';
                                }
                                return null;
                              },
                              controller: mailcontroller,
                              style: const TextStyle(color: Colors.black54),
                              decoration: const InputDecoration(
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                      fontSize: 18.0, color: Colors.black26),
                                  prefixIcon: Icon(
                                    Icons.person,
                                    color: Colors.black38,
                                    size: 30.0,
                                  ),
                                  border: InputBorder.none),
                            ),
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              if(_formkey.currentState!.validate()){
                                setState(() {
                                  email=mailcontroller.text;
                                });
                                resetPassword();
                              }
                            },
                            child: Container(
                              width: 140,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: CustomColors.primaryColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                child: Text(
                                  "Send Email",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                    fontSize: 18.0, color: Colors.black54),
                              ),
                              const SizedBox(
                                width: 5.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => const SignUp()));
                                },
                                child: const Text(
                                  "Create",
                                  style: TextStyle(
                                      color: Color.fromARGB(225, 184, 166, 6),
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}