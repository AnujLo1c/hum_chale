import 'dart:async';
// import 'package:email_auth/utils/constants/firebase_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hum_chale/screens/InitialLoginScreens/login_page.dart';
import 'package:hum_chale/screens/trip_booking/explore.dart';
class EmailVerificationScreen extends StatefulWidget {
  static var routeName="email-verification";
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
  isEmailVerified=false;
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();
    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
// TODO: implement your code after email verification
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Email Successfully Verified")));
      Navigator.popUntil(context, (route) => route.settings.name==LoginPage.routeName);
      timer?.cancel();
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
      canPop: false
      ,child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 35),
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    'Check your \n Email',
                    textAlign: TextAlign.center,
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
                  padding: EdgeInsets
                      .symmetric(horizontal: 32.0),
                  child: Center(
                    child: Text(
                      'Verifying email....',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 57),
                Padding(
                  padding: const EdgeInsets
                      .symmetric(horizontal: 32.0),
                  child: ElevatedButton(
                    child: const Text('Resend'),
                    onPressed: () {
                      try {
                        FirebaseAuth.instance.currentUser
                            ?.sendEmailVerification();

                      } catch (e) {
                        debugPrint('$e');
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets
                      .symmetric(horizontal: 32.0),
                  child: ElevatedButton(
                    child: const Text('Cancel Sign-Up'),
                    onPressed: () {
                      try {
                        FirebaseAuth.instance.currentUser
                            ?.delete();
                        Navigator.pop(context);

                      } catch (e) {
                        debugPrint('$e');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}