import 'package:flutter/material.dart';
import 'package:hum_chale/screens/InitialLoginScreens/login_page.dart';
import 'package:hum_chale/screens/InitialLoginScreens/sign_up.dart';
import 'package:hum_chale/screens/InitialLoginScreens/start_page.dart';
import 'package:hum_chale/screens/after_confirmation/ac_booking.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hum_chale/screens/trip_booking/explore.dart';

class GoogleLogin {
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        if(userCredential.additionalUserInfo!.isNewUser&& userCredential.user != null){
          // Navigator.pushReplacement(context, SignUp.routeName);
          Navigator.pushReplacementNamed(context, SignUp.routeName);
          print("new user");
        }
        else if(userCredential.user != null){
          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ACBooking(lodging: [])));
          Navigator.pushReplacementNamed(context, Explore.routeName);
          print("old user");
        }
        else{
          Navigator.pop(context);

        }
      } else {
        // Handle case where user cancels Google Sign-In
        print('User cancelled Google Sign-BuildContext contextIn');
      }
    } catch (e) {
      // Handle error during Google Sign-In
      print('Error signing in with Google: $e');
    }
  }

  void logOutFromGoogle(BuildContext context)async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut(); // Sign out from Google

      Navigator.popUntil(context, (route) => route.settings.name == LoginPage.routeName);
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
