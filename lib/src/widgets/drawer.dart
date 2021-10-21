import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:healthnowapp/src/models/user.dart';
import 'package:healthnowapp/src/models/wallet.dart';
import 'package:healthnowapp/src/screens/login.dart';
import 'package:healthnowapp/src/screens/orders.dart';
import 'package:healthnowapp/src/screens/pro-orders.dart';
import 'package:healthnowapp/src/screens/transactions.dart';
// import 'package:healthnow/src/models/user.dart';
// import 'package:healthnowapp/src/models/wallet.dart';
// import 'package:healthnowapp/src/screens/account.dart';
// import 'package:healthnowapp/src/screens/choose_delivery.dart';
// import 'package:healthnowapp/src/screens/orders.dart';
// import 'package:healthnowapp/src/screens/transactions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  Widget DrawerItem(context, text, action) {
    return ListTile(
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 20.0,
      ),
      title: Text(
        '$text',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
      ),
      onTap: () {
        // Update the state of the app
        // ...
        // Then close the drawer
        if (action == null) {
          print("nothing");
          Navigator.pop(context);
        }
        if (action == "account") {
          myaccount(context);
        }
        if (action == "delivery") {
          // Navigator.pushReplacement(
          //     context, new MaterialPageRoute(builder: (context) => Delivery())
          //     );
        }
        if (action == "orders") {
          orders(context);
        }
        if (action == "topups") {
          transactions(context);
        } else {
          print("report");
          // getUser(context);
        }
      },
    );
  }

  void myaccount(context) async {
    final pref = await SharedPreferences.getInstance();
    final k = 'user';
    var myuser = pref.getString(k) ?? '0';
    print(myuser);
    // Navigator.push(
    //     context,
    //     new MaterialPageRoute(
    //         builder: (context) => new Account(
    //               user: myuser,
    //             )));
  }

  void orders(context) async {
    final pref = await SharedPreferences.getInstance();
    final u = 'user';
    String user = pref.getString(u) ?? '0';
    final w = 'wallet';
    String wallet = pref.getString(w) ?? '0';
    String mywallet = wallet;
    User myuser = User.fromJson(jsonDecode(user));
    // convert to wallet first
    print(myuser);
    if(myuser.isProfessional){
      print("going to pro dashboard");
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new ProOrdersScreen(
                  user: myuser,
                  wallet: mywallet,
                )));
    }else{
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new OrdersScreen(
                  user: myuser,
                  wallet: mywallet,
                )));
    }
  }

  void transactions(context) async {
    //  get orders from api for this user
    final pref = await SharedPreferences.getInstance();
    final u = 'user';
    var user = pref.getString(u) ?? '0';
    final w = 'wallet';
    var wallet = pref.getString(w) ?? '0';
   
    // convert to wallet first
    // print(myuser);
    // ignore: unrelated_type_equality_checks
    if(wallet == "0"){
      Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new Login(
                  
                )));
    }else{
       Wallet mywallet = Wallet.fromJson(jsonDecode(wallet));
    User myuser = User.fromJson(jsonDecode(user));
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new TransactionScreen(
                  user: myuser,
                  wallet: mywallet,
                )));
                }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            AppBar(
              title: Text(
                "Menu",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => {
                  Navigator.pop(context),
                },
              ),
              backgroundColor: Color(0xFFef3131),
              elevation: 0,
            ),
            // DrawerItem(context, "My Account", "account"),
            Divider(),
            DrawerItem(context, "My Appoitments", 'orders'),
            // Divider(),
            // DrawerItem(context, "Topups", "topups"),
            // Divider(),
            // DrawerItem(context, "Delivery Type", "delivery"),
          ],
        ),
      ),
    );
  }
}
