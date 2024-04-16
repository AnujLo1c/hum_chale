import 'dart:async';
// import 'package:email_auth/utils/constants/firebase_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hum_chale/screens/InitialLoginScreens/login_page.dart';
import 'package:hum_chale/screens/trip_booking/explore.dart';
import 'package:hum_chale/ui/CustomColors.dart';
import 'package:hum_chale/widget/CustomAppBar.dart';

class EmailVerificationScreen extends StatefulWidget {
  static var routeName = "email-verification";
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  bool isEmailVerified = false;
  Timer? timer;
  @override
  void initState() {
// TODO: implement initState
    isEmailVerified = false;
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

//   checkEmailVerified() async {
//     await FirebaseAuth.instance.currentUser?.reload();
//
//     setState(() {
//       isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
//     });
//
//     if (isEmailVerified) {
// // TODO: implement your code after email verification
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text("Email Successfully Verified")));
//       Navigator.popUntil(context, (route) => route.settings.name==LoginPage.routeName);
//       timer?.cancel();
//     }
//   }

  checkEmailVerified() async {
    // Check if currentUser is not null before reloading
    if (FirebaseAuth.instance.currentUser != null) {
      await FirebaseAuth.instance.currentUser!.reload();

      setState(() {
        isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
      });

      if (isEmailVerified) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Email Successfully Verified")));
        Navigator.popUntil(
            context, (route) => route.settings.name == LoginPage.routeName);
        timer?.cancel();
      }
    }
  }

  @override
  void dispose() {
// TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gap(20),
                const Center(
                  child: Text(
                    'Verify Email',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Center(
                    child: Text(
                      'We have sent you a Email on ${FirebaseAuth.instance.currentUser?.email}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(child: CircularProgressIndicator()),
                const SizedBox(height: 8),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Center(
                    child: Text(
                      '\nVerifying email....',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.deleteColor,
                          elevation: 5,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)))),
                      child: const Text('Cancel',style: TextStyle(fontSize: 16),),
                      onPressed: () {
                        try {
                          FirebaseAuth.instance.currentUser?.delete();
                          Navigator.pop(context);
                        } catch (e) {
                          debugPrint('$e');
                        }
                      },
                    ),
                    Gap(10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColors.primaryColor,
                          elevation: 5,
                          foregroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)))),
                      child: const Text(
                        'Resend',
                        style: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        try {
                          FirebaseAuth.instance.currentUser
                              ?.sendEmailVerification();
                        } catch (e) {
                          debugPrint('$e');
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
