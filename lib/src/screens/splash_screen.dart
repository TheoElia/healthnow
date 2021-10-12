import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthnowapp/src/data/data.dart';
import 'package:healthnowapp/src/screens/dashboard_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    getCategories().then((value) {
      finish(context);
      DashBoard(categories: value).launch(context);
    });
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
