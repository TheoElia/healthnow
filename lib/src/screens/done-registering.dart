import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthnowapp/src/models/user.dart';
import 'package:healthnowapp/src/screens/pro-orders.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoneRegister extends StatefulWidget {
  @override
  _DoneRegisterState createState() => _DoneRegisterState();
}

class _DoneRegisterState extends State<DoneRegister> {
  void delay() {
    Future.delayed(Duration(seconds: 3), () {
      // Navigator.pushNamed(context, '/onboarding');
      // Navigator.pushReplacement(context,new MaterialPageRoute(builder: (context) => new OnboardingScreen()));
      read('user');
    });
  }

  read(k) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$k';
    final value = prefs.getString(key) ?? '0';
    print('read: $value');
    if (value == '0') {
      // user does not have a user
      // Navigator.pushReplacement(
      //     context, new MaterialPageRoute(builder: (context) => new Signup())
      //     );
    } else {
      // get user and pass it
      // Navigator.pushReplacement(
      // context, new MaterialPageRoute(builder: (context) => new Cart(products: [],))
      // );
      // Navigator.pushReplacement(
      //     context, new MaterialPageRoute(builder: (context) => Delivery())
      //     );
    }
    // return value;
    // print('read: $value');
  }

  goToDashboard() async{
    final pref = await SharedPreferences.getInstance();
    final u = 'user';
    String user = pref.getString(u) ?? '0';
    final w = 'wallet';
    String wallet = pref.getString(w) ?? '0';
    String mywallet = wallet;
    User myuser = User.fromJson(jsonDecode(user));
    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => 
                          new ProOrdersScreen(user: myuser,wallet: mywallet,)));
  }

  @override
  void initState() {
    super.initState();
    delay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            child: new Stack(
          children: ([
          Center(
            child: Image(
              image: AssetImage(
                'assets/images/verified.png',
              ),
              height: 150.0,
              width: 150.0,
            ),
          ),
          Center(
            child:
          Column(  
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
            Container(
            child: Text(
                  "Verified",
                  style: new TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800]
                    // foreground: Paint()..shader = linearGradient
                  ),
                  textAlign: TextAlign.center,
                ),
          ),
          SizedBox(height: 10,),
              Center(
                child: Text(
                  "All your information has checked out.\nPlease Check your email for our terms and conditions. Thank You",
                  style: new TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600]
                    // foreground: Paint()..shader = linearGradient
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 10,),
              Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: ButtonTheme(
                minWidth: 300.0,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  child: Text(
                    'Go to Dashboard',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      // height: 1.0,
                    ),
                  ),
                  onPressed: () {
                    // take professional to their dashboard
                    
                     goToDashboard();

                  },
                  color: Color(0xFFef3131),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(15),
                  splashColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(color: Color(0xFFef3131)),
                  ),
                ),
              ),
            ),
          ),
              SizedBox(
                height: 100,
              )
            ],
          ),
          ),
        ]
        )
        )
        )
        );
  }

  Widget myTextComponent(Color color, String text,
      {double size = 30,
      FontWeight weight = FontWeight.w700,
      TextAlign align = TextAlign.center}) {
    return Text(text,
        textAlign: align,
        style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          color: color,
        ));
  }
}
