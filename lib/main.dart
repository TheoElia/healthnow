import 'package:flutter/material.dart';
import 'package:healthnowapp/src/screens/choice.dart';
import 'package:healthnowapp/src/screens/dashboard_screen.dart';

void main() => 
runApp( MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => DashBoard(), 
        },
      ),
    );
