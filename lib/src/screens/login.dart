import 'package:flutter/material.dart';
import 'package:healthnowapp/src/screens/choice.dart';
import 'package:healthnowapp/src/screens/dashboard_screen.dart';
import 'package:healthnowapp/src/screens/register.dart';
import 'dart:convert';
import 'package:http/http.dart';







import 'package:shared_preferences/shared_preferences.dart';




class Login extends StatefulWidget {
  
  
  
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    
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
                          """Log Into Your Account""",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 20.0,
                            
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


class MyCustomForm extends StatefulWidget {
  final String phone;
  final String pin;
  MyCustomForm({required this.phone, required this.pin}) : super();
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}



class MyCustomFormState extends State<MyCustomForm> {
  
  
  
  
  

  void Login(email, password) async {
    showLoaderDialog(context, "Please wait...");
    final pref = await SharedPreferences.getInstance();
    final k = 'uuid';
    final myuid = pref.getString(k) ?? '0';
    final number = "233" + email;
    print(number);
    print(password);
    Map<String, String> requestHeaders = {
      
      'Accept': 'application/json',
      
      
    };

    Response response =
        await post(Uri(),
            headers: requestHeaders,
            body: jsonEncode({
              'phone': number,
              'password': password,
              'refer': ''
              
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
      
      
      
    } else {
      Navigator.of(context, rootNavigator: true).pop();
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text(data['message']));
          });
      
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
    
    prefs.setString(key, val);
    print('saved $val');
  }

  _saveObj(keyi, val) async {
    final prefs = await SharedPreferences.getInstance();
    final key = '$keyi';
    
    prefs.setString(key, val);
    print('saved $val');
  }

  final _formKey = GlobalKey<FormState>();
  
  final email = TextEditingController();
  final password = TextEditingController();
  final countryCode = "233";

  @override
  Widget build(BuildContext context) {
    

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
            child: Text("Email", style: TextStyle(
                            color: Colors.grey[800],
                            fontSize: 15.0,
                            
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
                hintText: 'Email',
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
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Center(
              child: ButtonTheme(
                minWidth: 300.0,
                
                child: RaisedButton(
                  child: Text(
                    'login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      
                    ),
                  ),
                  onPressed: () {
                    
                    
                    
                    Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                          builder: (context) => 
                          new DashBoard()));
                    
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
                "Don't have an account?",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.end,
              ),
              TextButton(
                child: Text(
                  "  Sign Up",
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
                          new Choice()));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
