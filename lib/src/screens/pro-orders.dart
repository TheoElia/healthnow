import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthnowapp/src/screens/chatscreen.dart';
import 'package:http/http.dart';
import 'package:healthnowapp/src/models/order.dart';
import 'package:healthnowapp/src/models/user.dart';
import 'package:healthnowapp/src/models/wallet.dart';
// import 'package:healthnowapp/src/screens/order_receipt.dart';
import 'package:healthnowapp/src/services/webservice.dart';
import 'package:healthnowapp/src/widgets/Colors.dart';
import 'package:healthnowapp/src/widgets/Style.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProOrdersScreen extends StatefulWidget {
  final user;
  final wallet;
  ProOrdersScreen({ this.wallet, this.user}) ;
  @override
  _ProOrdersScreenState createState() => _ProOrdersScreenState();
}

class _ProOrdersScreenState extends State<ProOrdersScreen> {
  late Wallet mywallet;
  late User myuser;
  var baseUrl = "https://healthnow.pywe.org";
  List<dynamic> orders = [];
  bool loading = false;
  Future<void> _launchURL(url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  void _populateOrders() {
    Webservice().load(Order.all).then((inorders) => {
          setState(() {
            orders = inorders;
          }),
        });
  }

  @override
  void initState() {
    super.initState();
    getUser(widget.user.username);
    mywallet = Wallet.fromJson(jsonDecode(widget.wallet));
    _populateOrders();
  }

  showLoaderDialog(BuildContext context, text) {
    AlertDialog alert = AlertDialog(
      content: Row(
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

  void getUser(number) async {
    print(" me this");
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
    };

    Response response = await post(
        Uri.parse('https://healthnow.pywe.org/api/v1/accounts/get-user/'),
        headers: requestHeaders,
        body: jsonEncode({
          'username': number
        }));
    print(response.body);
    Map data = jsonDecode(response.body);
    print(data);
    if (data['success']) {
      var user = data['user']['user'];
      var wallet = data['user']['wallet'];
      print(wallet);
      _saveObj('user', jsonEncode(user));
      _saveObj('wallet', jsonEncode(wallet));
      setState(() {
        mywallet = Wallet.fromJson(wallet);
      print(mywallet);

      });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text(data['message']));
          });
      // Navigator.pushReplacement(context,new MaterialPageRoute(builder: (context) => new SetPin(text: phone,)));
    }
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

  void getWallet() async {
    final pref = await SharedPreferences.getInstance();
    final k = 'wallet';
    var myuser = pref.getString(k) ?? '0';
    print("wallet");
    print(myuser);
    mywallet = Wallet.fromJson(jsonDecode(myuser));
    print(mywallet);
  }

  void chargeUser(form) async {
    showLoaderDialog(context, "Making payment...");
    Map<String, String> requestHeaders = {
      // 'Content-type': 'application/json',
      'Accept': 'application/json',
      // 'Token':'AAAAIl3GvqE:APA91bEJ3NkSzL6YrdyTfuEVXJPSjgve5qs_h3cX8MA82mrU2HetPRxf_',
      // 'KeyCode': myuid
    };

    Response response = await post(
        Uri.parse(baseUrl + '/api/v1/accounts/charge-user/'),
        headers: requestHeaders,
        body: jsonEncode(form));
    Map data = jsonDecode(response.body);
    print(data);
    // let's get the new wallet
    if (data['success']) {
      print(data);
      Wallet newwallet = Wallet.fromJson(data['wallet']);
      setState(() {
        mywallet = newwallet;
      });
      print(newwallet);
      _populateOrders();
      Navigator.of(context, rootNavigator: true).pop();
      // send user to receipt screen
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
   void makeRequest(link,id,act) async {
    showLoaderDialog(context, "Updating the request...");
    final pref = await SharedPreferences.getInstance();
    final String k = 'uuid';
    final String myuid = pref.getString(k) ?? '0';
    // final String number = myphone.toString();
    print(myuid);
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
    };

    Response response =
        await post(Uri.parse('https://healthnow.pywe.org/api/v1/services/update-request/'),
            headers: requestHeaders,
            body: jsonEncode({
              'meeting_link': "https://"+link,
              'id': id,
              'accepted':act
            }));
    print(response.body);
    Map data = jsonDecode(response.body);
    print(data);
    if (data['success']) {   
      print(data);
      Navigator.of(context).pop();

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text("Request has been sent!"));
          });
      // setState(() {
      //   submitting = false;
      // });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text(data['message']));
          });
      // Navigator.pushReplacement(context,new MaterialPageRoute(builder: (context) => new SetPin(text: phone,)));
    }
  }
  acceptOrDecline(BuildContext aContext,id) {
    
  var meeting_link = TextEditingController();
  var phone = TextEditingController();
  var consult_phone = TextEditingController();
  var complaint = TextEditingController();

  var signature = TextEditingController();
  var formKey = GlobalKey<FormState>();
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: aContext,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              padding: EdgeInsets.all(16),
              child: Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Accept or Decline This Request",
                      style: boldTextStyle(letterSpacing: 2,wordSpacing: 2),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      "Enter a google meet link in the box below if you choose to accept the request",
                      style: primaryTextStyle(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Divider(),
                    ), 
                    Text(
                      "Create and copy a new meeting link using the button below and paste the link in the box",
                      style: primaryTextStyle(),
                    ),
                     SizedBox(height: 5,),
                    GestureDetector(
                            onTap: () {
                              launch("https://meet.google.com");
                              // makeRequest(meeting_link.text,id,true);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.9,
                              decoration: boxDecoration(
                                  backGroundColor: Color(0xFF4caf50),
                                  radius: 16),
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                              child: Center(
                                child: Text("Create New Meeting",
                                    style:
                                        boldTextStyle(textColor: Colors.white,letterSpacing: 2,wordSpacing: 2)),
                              ),
                            ),
                          ), 
                     SizedBox(height: 10,),
                    Text(
                      "Meeting Link",
                      style: primaryTextStyle(),
                    ),
                    SizedBox(height: 5),
                    Container(
                      margin: EdgeInsets.all(2.0),
                      child: TextFormField(
                        minLines: 5,
                        maxLines: 7,
                        cursorColor: Colors.grey,
                        autofocus: false,
                        validator: (value) {
                          return null;
                        },
                        controller: meeting_link,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.fromLTRB(24, 16, 24, 16),
                          hintText: "Paste meeting link here",
                          hintStyle: primaryTextStyle(textColor: Colors.grey),
                          filled: true,
                          fillColor: Colors.grey[200],
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Colors.grey, width: 1.0)
                                  ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide(
                                  color: Colors.grey, width: 1.0)),
                        ),
                      ),
                    ),                 
                    
                    SizedBox(height: 30),
                    Row(children: [
                      GestureDetector(
                            onTap: () {
                              // launch("https://wa.me/233500459013?text=Hello%20%20Josefina,I%20need%20help%20with%20Pharst%20Care.%20");
                              makeRequest(meeting_link.text,id,true);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.4,
                              decoration: boxDecoration(
                                  backGroundColor: Color(0xFF4caf50),
                                  radius: 16),
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                              child: Center(
                                child: Text("Accept",
                                    style:
                                        boldTextStyle(textColor: Colors.white,letterSpacing: 2,wordSpacing: 2)),
                              ),
                            ),
                          ),
                        
                          SizedBox(width:MediaQuery.of(context).size.width * 0.1 ,),
                       GestureDetector(
                            onTap: () {
                            //  launch("tel:0554813575"); 
                            makeRequest("",id,false);  
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              decoration: boxDecoration(
                                  backGroundColor: Color(0xFF007BFF),
                                  radius: 16),
                              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                              child: Center(
                                child: Text("Decline",
                                    style:
                                        boldTextStyle(textColor: Colors.white, letterSpacing: 2, wordSpacing: 2)),
                              ),
                            ),
                          )
                        
                    ],)
                    
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    myuser = widget.user;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Client Requests"),
        backgroundColor: Color(0xFFef3131),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        left: 24, right: 24, top: 16, bottom: 30),
                    margin: EdgeInsets.all(16),
                    decoration: boxDecoration(
                        radius: 16,
                        shadowColor: opPrimaryColor.withOpacity(0.2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Align(
                          child: Text(
                            'Appointment Wallet',
                            style: boldTextStyle(
                                size: 20, textColor: Colors.white, letterSpacing: 2,wordSpacing: 2),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Text(
                            'GHC ${mywallet.serviceAccount}',
                            style: boldTextStyle(
                                size: 30, textColor: Colors.white,letterSpacing: 2,wordSpacing: 2),
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.white30,
                        ),
                        Container(
                          width: 100,
                          height: 35,
                          margin: EdgeInsets.fromLTRB(5, 5, 5, 15),
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                side: BorderSide(color: Colors.transparent),
                              ),
                              color: Colors.white,
                              child: Text(
                                'Withdraw',
                                style: TextStyle(color: Colors.black),
                              ),
                              onPressed: () {
                                var url =
                                    "https://healthnow.pywe.org/accounts/topup/" +
                                        myuser.id.toString();
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                                _launchURL(url);
                              }),
                        ),
                        FittedBox(
                          child: RichText(
                            text: TextSpan(
                                text: 'Your Card, Powered by',
                                style: secondaryTextStyle(
                                    textColor: Colors.white60),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' Pywe Pay',
                                    style: primaryTextStyle(
                                        textColor: Colors.white),
                                  )
                                ]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * .58,
                    child: orders.isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.all(5),
                            itemCount: orders.length,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin: EdgeInsets.all(5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(20, 0, 20, 15),
                                      padding:
                                          EdgeInsets.fromLTRB(5, 13, 5, 13),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          // Text(
                                          //   '${orders[index]['status']}',
                                          //   style:
                                          //       TextStyle(color: Colors.grey),
                                          // ),
                                          Container(
                                            width: MediaQuery.of(context).size.width*0.3,
                                            child: Text(
                                              '${orders[index]['message']}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,color: Colors.grey[800]),
                                            ),
                                          ),
                                          Text(
                                            'GHC${orders[index]['consultation_fee']}',
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          if (!orders[index]['paid'])
                                            Container(
                                              width: 80,
                                              height: 35,
                                              child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    side: BorderSide(
                                                        color:
                                                            Colors.transparent),
                                                  ),
                                                  color: Colors.green,
                                                  child: Text(
                                                    'Action',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    if(orders[index]['status'] == "accepted" || orders[index]['status'] == "declined"){}else{
                                                    acceptOrDecline(context,orders[index]['id']);
                                                    }
                                                  }),
                                            ),
                                          if (orders[index]['paid'])
                                            Container(
                                              width: 80,
                                              height: 35,
                                              child: RaisedButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    side: BorderSide(
                                                        color:
                                                            Colors.transparent),
                                                  ),
                                                  color: Color(0xFFef3131),
                                                  child: Text(
                                                    'Access',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  onPressed: () {
                                                    print(widget.user.id);
                                                    Navigator.push(
                                                        context,
                                                        new MaterialPageRoute(
                                                            builder: (context) =>
                                                                new ChatScreen(img: 'assets/images/img1.png',name: 'My Client',senderId: orders[index]['professional_username'],receiverId: orders[index]['patient_username'],meetingLink:orders[index]['meeting_link'])));
                                                    
                                                  }),
                                            )
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          stops: [0.015, 0.015],
                                          colors: [Colors.purple, Colors.white],
                                        ),
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5.0),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color.fromRGBO(
                                                207, 207, 207, 1),
                                            blurRadius: 10.0,
                                            spreadRadius: 5.0,
                                            offset: Offset(0.0, 0.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })
                        : Center(
                            child: Text("No Appointment available")),
                  ),
                ],
              ),
              // Center(
              //   child: Padding(
              //     padding: const EdgeInsets.all(16.0),
              //     child: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: <Widget>[
              //         ButtonBars(
              //           title: 'Print',
              //           icon: Icons.print,
              //           color: opPrimaryColor,
              //         ),
              //         ButtonBars(
              //           title: 'Clear',
              //           icon: Icons.assignment_return,
              //           color: opOrangeColor,
              //           onPressed: () {},
              //         ),
              //       ],
              //     ),
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
