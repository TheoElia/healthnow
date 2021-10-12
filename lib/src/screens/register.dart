import 'package:flutter/material.dart';
import 'package:healthnowapp/src/screens/chatscreen.dart';
import 'package:healthnowapp/src/screens/dashboard_screen.dart';
import 'package:healthnowapp/src/screens/login.dart';
import 'dart:convert';
import 'package:http/http.dart';
// import 'package:healthnowapp/src/models/vendor.dart';
// import 'package:healthnowapp/src/screens/accounts/create_account.dart';
// import 'package:healthnowapp/src/screens/accounts/enterpin.dart';
// import 'package:healthnowapp/src/screens/choose_delivery.dart';
// import 'package:healthnowapp/src/screens/landing.dart';
// import 'package:healthnowapp/src/screens/verifypin.dart';
// import 'package:healthnowapp/src/services/webservice.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uuid/uuid.dart';

// WeatherFactory wf = new WeatherFactory("0e5caa39057529fec21b1e8b76123ac8");

class Register extends StatefulWidget {
  // final String phone;
  // final String pin;
  // Register({Key key, @required this.phone, this.pin}) : super(key: key);
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    // final appTitle = 'Hisense Care+';
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    // title: appTitle,
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          
            reverse: false,
            child: Padding(
                padding: EdgeInsets.only(bottom: bottom),
                child: SafeArea(
                    child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Center(
                        child: Text(
                          """Create A Free Account""",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 20.0,
                            // height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        child: MyCustomForm(
                          phone: '',
                          pin: '',
                        )),
                  ]),
                )))));
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  final String phone;
  final String pin;
  MyCustomForm({required this.phone, required this.pin}) : super();
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.

  void Register(email, password) async {
    showLoaderDialog(context, "Please wait...");
    final pref = await SharedPreferences.getInstance();
    final k = 'uuid';
    final myuid = pref.getString(k) ?? '0';
    final number = "233" + email;
    print(number);
    print(password);
    Map<String, String> requestHeaders = {
      // 'Content-type': 'application/json',
      'Accept': 'application/json',
      // 'Token':'AAAAIl3GvqE:APA91bEJ3NkSzL6YrdyTfuEVXJPSjgve5qs_h3cX8MA82mrU2HetPRxf_',
      // 'KeyCode': myuid
    };

    Response response =
        await post(Uri(),
            headers: requestHeaders,
            body: jsonEncode({
              'phone': number,
              'password': password,
              'refer': ''
              // "FireBaseKey": "37473483743874",
            }));
    print(response.body);
    Map data = jsonDecode(response.body);
    print(data);
    if (data['success']) {
      var user = data['user']['user'];
      var settings = data['user']['settings'];
      var profile = data['user']['profile'];
      var wallet = data['user']['wallet'];
      _saveObj('user', jsonEncode(user));
      _saveObj('settings', jsonEncode(settings));
      _saveObj('profile', jsonEncode(profile));
      _saveObj('wallet', jsonEncode(wallet));
      print(data);
      // Navigator.pushReplacement(
      //     context, new MaterialPageRoute(builder: (context) => Delivery()
      //     ));
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text(data['message']));
          });
      // Navigator.pushReplacement(context,new MaterialPageRoute(builder: (context) => new SetPin(text: phone,)));
    }
  }

  showLoaderDialog(BuildContext context, text) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(color: Color(0xFFef3131)),
          Container(margin: EdgeInsets.only(left: 7), child: Text("$text")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _save(val) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'otp';
    // final value = 42;
    prefs.setString(key, val);
    print('saved $val');
  }

  _saveObj(keyi, val) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$keyi';
    // final value = 42;
    prefs.setString(key, val);
    print('saved $val');
  }

  final _formKey = GlobalKey<FormState>();
  // of the TextField.
  final email = TextEditingController();
  final password = TextEditingController();
  final countryCode = "233";

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 5,bottom: 5),
            child: Text("First Name", style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 15.0,
                            // height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
            
          ),
          Container(
            margin: EdgeInsets.all(2.0),
            width: MediaQuery.of(context).size.width * 0.85,
            child: 
            Material(
              elevation: 10.0,
              shadowColor: Colors.grey,
              child:TextFormField(
              cursorColor: Colors.grey,
              validator: (value) {
                // if (value.isEmpty) {
                //   return 'Please Enter Password';
                // }
                return null;
              },
              controller: email,
              obscureText: false,
              decoration: 
              new InputDecoration(
                isCollapsed: false,
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                ),
                 border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(15.0),
                ),  
                hintText: 'Enter First Name',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 5,bottom: 5),
            child: Text("Last Name", style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 15.0,
                            // height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
            
          ),
          Container(
            margin: EdgeInsets.all(2.0),
            width: MediaQuery.of(context).size.width * 0.85,
            child: 
            Material(
              elevation: 10.0,
              shadowColor: Colors.grey,
              child:TextFormField(
              cursorColor: Colors.grey,
              validator: (value) {
                // if (value.isEmpty) {
                //   return 'Please Enter Password';
                // }
                return null;
              },
              controller: email,
              obscureText: false,
              decoration: 
              new InputDecoration(
                isCollapsed: false,
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                ),
                 border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(15.0),
                ),  
                hintText: 'Enter Last Name',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 5,bottom: 5),
            child: Text("Age", style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 15.0,
                            // height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
            
          ),
          Container(
            margin: EdgeInsets.all(2.0),
            width: MediaQuery.of(context).size.width * 0.85,
            child: 
            Material(
              elevation: 10.0,
              shadowColor: Colors.grey,
              child:TextFormField(
              cursorColor: Colors.grey,
              validator: (value) {
                // if (value.isEmpty) {
                //   return 'Please Enter Password';
                // }
                return null;
              },
              controller: email,
              obscureText: false,
              decoration: 
              new InputDecoration(
                isCollapsed: false,
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                ),
                 border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(15.0),
                ),  
                hintText: 'How old are you?',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 5,bottom: 5),
            child: Text("Email", style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 15.0,
                            // height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
            
          ),
          Container(
            margin: EdgeInsets.all(2.0),
            width: MediaQuery.of(context).size.width * 0.85,
            child: 
            Material(
              elevation: 10.0,
              shadowColor: Colors.grey,
              child:TextFormField(
              cursorColor: Colors.grey,
              validator: (value) {
                // if (value.isEmpty) {
                //   return 'Please Enter Password';
                // }
                return null;
              },
              controller: email,
              obscureText: false,
              decoration: 
              new InputDecoration(
                isCollapsed: false,
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                ),
                 border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(15.0),
                ),  
                hintText: 'Enter Valid Email',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 5,bottom: 5),
            child: Text("Password", style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 15.0,
                            // height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
          ),
          Container(
            margin: EdgeInsets.all(2.0),
            width: MediaQuery.of(context).size.width * 0.85,
            child: 
            Material(
              elevation: 10.0,
              shadowColor: Colors.grey,
              child:
            TextFormField(
              cursorColor: Colors.grey,
              showCursor: true,
              validator: (value) {
                // if (value.isEmpty) {
                //   return 'Please Enter Password';
                // }
                return null;
              },
              controller: password,
              obscureText: true,
              decoration: new InputDecoration(  
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white, width: 0.0),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    borderRadius: BorderRadius.circular(15.0),
                ),  
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),),
          ),
          SizedBox(
            height: 10.0,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   children: <Widget>[
          //     Container(
          //       width: 300,
          //       child: Text(
          //         """By signing up, you agree to our terms and privacy policy""",
          //         style: TextStyle(
          //           fontSize: 15,
          //           color: Colors.white,
          //         ),
          //         textAlign: TextAlign.end,
          //         maxLines: 3,
          //       ),
          //     ),
          //   ],
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: ButtonTheme(
                minWidth: 300.0,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      // height: 1.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => 
                          new DashBoard()));
                    //  Navigator.pushReplacement(
                    //   context,
                    //   new MaterialPageRoute(
                    //       builder: (context) => 
                    //       new ChatScreen(img: 'assets/images/doctor.png', name: 'Dr. Kofi')));
                    // Validate returns true if the form is valid, or false
                    // otherwise.
                    // if (_formKey.currentState.validate()) {
                    //   Register(email.text, password.text);
                    // }
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
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Already have an account?",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.end,
              ),
              TextButton(
                child: Text(
                  "  Login",
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFef3131),
                  ),
                  textAlign: TextAlign.end,
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => 
                          new Login()));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
