import 'package:firebase_auth/firebase_auth.dart';
import 'package:hum_chale/screens/InitialLoginScreens/login_page.dart';
import 'package:hum_chale/screens/InitialLoginScreens/start_page.dart';
import 'package:hum_chale/screens/custom_bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SharedPref{
  LoginSP(username, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
    await prefs.setString('method', "ep");
  }

  LoginGSP(email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', email);
    await prefs.setString('method', "g");
  }

  isLoggedinSP(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var m = await prefs.getString('method');
    print(m);
    if (m == "ep") {
      var UN = await prefs.getString('username');
      var PW = await prefs.getString('password');
      if (UN != null && PW != null) {
        Navigator.pushReplacementNamed(context, CustomBottomNav.routeName);
      } else {
        Navigator.pushReplacementNamed(context, StartPage.routeName);
      }
    } else if (m == "g") {
      var UN = await prefs.getString('username');
      var e = FirebaseAuth.instance.currentUser?.email;
      if (e != null) {
        if (UN?.compareTo(e) == 0) {
          Navigator.pushReplacementNamed(context, CustomBottomNav.routeName);
        } else {
          Navigator.pushReplacementNamed(context, StartPage.routeName);
        }
      }
    } else {
      Navigator.pushReplacementNamed(context, StartPage.routeName);
    }
  }
  LogoutSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var m = await prefs.getString('method');
    if (m == "ep") {
      await prefs.remove('username');
      await prefs.remove('password');
    } else if (m == "g") {
      await prefs.remove('username');
    }
    await prefs.remove('method');
  }
}