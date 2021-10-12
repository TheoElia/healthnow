import 'package:flutter/material.dart';
import 'package:healthnowapp/src/screens/splash_screen.dart';

void main() => 
runApp( MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(), 
        },
      ),
    );
