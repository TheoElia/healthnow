import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthnowapp/src/data/data.dart';
import 'package:healthnowapp/src/models/user.dart';
import 'package:healthnowapp/src/screens/dashboard_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool userExists = false;
  @override
  void initState() {
    super.initState();
    whoIsUser();
    init();
  }

  init() async {
    getCategories().then((value) {
      finish(context);
      DashBoard(
        categories: value,
        isProfessional: userExists,
      ).launch(context);
    });
  }

  whoIsUser() async {
    final pref = await SharedPreferences.getInstance();
    final u = 'user';
    String user = pref.getString(u) ?? '0';
    if (user != '0') {
      User myuser = User.fromJson(user);
      print(myuser);
      setState(() {
        if (myuser.isProfessional) {
          userExists = true;
        } else {
          userExists = false;
        }
      });
    } else {
      userExists = false;
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Your HealthNow",
          style: TextStyle(
              color: Colors.red.withOpacity(0.8),
              fontSize: 30,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
