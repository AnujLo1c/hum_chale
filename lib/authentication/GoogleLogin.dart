import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hum_chale/screens/InitialLoginScreens/sign_up_google.dart';
import 'package:hum_chale/screens/InitialLoginScreens/start_page.dart';
import 'package:hum_chale/screens/trip_booking/explore.dart';
import 'package:hum_chale/widget/loading-dialog.dart';

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
        LoadingDialog().loadingDialog(context);
        // print(googleUser.email);
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

        if(userCredential.additionalUserInfo!.isNewUser&& userCredential.user != null){
          Navigator.pushReplacementNamed(context, SignUpG.routeName);
          print("new user");
        }
        else if(userCredential.user != null){

          Navigator.pushReplacementNamed(context, Explore.routeName);
          print("old user");
        }
        else{
          Navigator.pop(context);
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

      // Navigator.popUntil(context, (route) => route.settings.name == LoginPage.routeName);

      Navigator.pushReplacementNamed(context, StartPage.routeName);
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
