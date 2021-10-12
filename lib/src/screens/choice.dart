import 'package:flutter/material.dart';
import 'package:healthnowapp/src/screens/pro-register.dart';
import 'package:healthnowapp/src/screens/register.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Choice extends StatefulWidget {
  @override
  _ChoiceState createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
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
                          """Who are you please?""",
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

  void Choice(email, password) async {
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
            padding: EdgeInsets.only(left: 10,bottom: 5),
            child: Text("Choose if normal user", style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 15.0,
                            // height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
            
          ),
           Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: ButtonTheme(
                minWidth: 300.0,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  child: Text(
                    'Patient',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      // height: 1.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => 
                          new Register()));
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
          Container(
            padding: EdgeInsets.only(left: 10,bottom: 5),
            child: Text("Choose if medical professional", style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 15.0,
                            // height: 1.5,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: ButtonTheme(
                minWidth: 300.0,
                // ignore: deprecated_member_use
                child: RaisedButton(
                  child: Text(
                    'Practitioner',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      // height: 1.0,
                    ),
                  ),
                  onPressed: () {
                   Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => 
                          new ProRegister()));
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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text(
          //       "Don't have an account?",
          //       style: TextStyle(
          //         fontSize: 15,
          //         color: Colors.grey[600],
          //       ),
          //       textAlign: TextAlign.end,
          //     ),
          //     TextButton(
          //       child: Text(
          //         "  Sign Up",
          //         style: TextStyle(
          //           fontSize: 18,
          //           color: Color(0xFFef3131),
          //         ),
          //         textAlign: TextAlign.end,
          //       ),
          //       onPressed: () {
          //         Navigator.pushReplacement(
          //             context,
          //             new MaterialPageRoute(
          //                 builder: (context) => 
          //                 new Register()));
          //       },
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
