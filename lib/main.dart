import 'package:flutter/material.dart';
import 'package:healthnowapp/src/data/messaging_provider.dart';
import 'package:healthnowapp/src/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MessagingProvider()),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => SplashScreen(),
        },
      ),
    ),
  );
}
