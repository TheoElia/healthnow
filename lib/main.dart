import 'package:flutter/material.dart';
import 'package:healthnowapp/src/screens/choice.dart';

void main() => 
runApp( MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => Choice(), 
        },
      ),
    );
