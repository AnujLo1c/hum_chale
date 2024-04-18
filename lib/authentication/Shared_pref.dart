import 'package:hum_chale/screens/InitialLoginScreens/login_page.dart';
import 'package:hum_chale/screens/custom_bottom_nav.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class SharedPref{
  LoginSP(username, password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username);
    await prefs.setString('password', password);
  }
  isLoggedinSP(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var UN = await prefs.getString('username');
    var PW = await prefs.getString('password');

    if (UN != null && PW != null) {
      Navigator.pushReplacementNamed(context, CustomBottomNav.routeName);
    } else {
      Navigator.pushReplacementNamed(context, LoginPage.routeName);
    }
  }
  LogoutSP() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('username');
    await prefs.remove('password');
  }
}