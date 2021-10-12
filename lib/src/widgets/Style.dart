import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Colors.dart';

TextStyle primaryTextStyle(
    {int size = 16,
    Color textColor = opTextPrimaryColor,
    fontFamily = fontRegular}) {
  return TextStyle(
      fontSize: size.toDouble(), color: textColor, fontFamily: fontFamily);
}

TextStyle secondaryTextStyle(
    {int size = 14,
    Color textColor = opTextSecondaryColor,
    fontFamily = fontRegular}) {
  return TextStyle(
      fontSize: size.toDouble(), color: textColor, fontFamily: fontFamily);
}

TextStyle boldTextStyle(
    {int size = 18,
    Color textColor = opTextPrimaryColor,
    FontWeight textWeight = FontWeight.bold,
    required double letterSpacing,
    required double wordSpacing}) {
  return TextStyle(
      fontSize: size.toDouble(),
      color: textColor,
      fontWeight: textWeight,
      letterSpacing: letterSpacing,
      fontFamily: fontBold,
      wordSpacing: wordSpacing);
}

BoxDecoration boxDecoration(
    {double radius = 80.0,
    Color backGroundColor = opPrimaryColor,
    double blurRadius = 8.0,
    double spreadRadius = 8.0,
    shadowColor = Colors.black12}) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    boxShadow: [
      BoxShadow(
        color: shadowColor,
        blurRadius: blurRadius,
        spreadRadius: spreadRadius,
      ),
    ],
    color: backGroundColor,
  );
}

const dot = CircleAvatar(
  radius: 2.5,
  backgroundColor: Color(0xFF343EDB),
);

Widget applogo() {
  return Image.asset(
    'images/orapay/opsplash.png',
    width: 36,
    height: 36,
    fit: BoxFit.fill,
  );
}

Widget ButtonBars(
    {required String title,
    required Size size,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed}) {
  return FlatButton(
    onPressed: onPressed,
    child: Container(
      height: 50,
      width: 110,
      decoration: boxDecoration(backGroundColor: color),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(title, style: primaryTextStyle(textColor: Colors.white))
        ],
      ),
    ),
  );
}

Widget indicator({required bool isActive}) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 150),
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    height: isActive ? 6.0 : 4.0,
    width: isActive ? 6.0 : 4.0,
    decoration: BoxDecoration(
      color: isActive ? Colors.white : Color(0xFF929794),
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
  );
}

Widget textField({
  required String title,
  required IconData image,
  required TextInputType textInputType,
}) {
  return TextField(
    keyboardType: textInputType,
    decoration: InputDecoration(
      hintText: title,
      hintStyle: secondaryTextStyle(size: 16),
      fillColor: Colors.grey,
      suffixIcon: Icon(
        image,
        color: Colors.grey,
        size: 20,
      ),
    ),
  );
}

Widget textField2({
  required String title,
  required IconData image,
  required TextInputType textInputType,
}) {
  return TextField(
    keyboardType: textInputType,
    autocorrect: true,
    style: TextStyle(color: Colors.white, fontSize: 18),
    decoration: InputDecoration(
      hintText: title,
      enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Colors.white)),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      hintStyle: TextStyle(color: Colors.white54, fontSize: 14),
      fillColor: Colors.white54,
      prefixIcon: Icon(image, color: Colors.white54),
    ),
  );
}

Widget VerifyCards(
    {required final Size size,
    required String title,
    required String subtitle,
    required String image,
    required Color color}) {
  return Container(
    decoration: boxDecoration(
        backGroundColor: color, radius: 24, spreadRadius: 2, blurRadius: 4),
    child: Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: boldTextStyle(size: 18, textColor: Colors.white,letterSpacing: 2,wordSpacing: 2),
                ),
                Text(
                  subtitle,
                  style: primaryTextStyle(size: 16, textColor: Colors.white54),
                ),
              ],
            ),
          ),
          Image.asset(
            image,
            height: 80,
            width: 80,
          ),
        ],
      ),
    ),
  );
}

Widget CardDetails({
  required String visaTitle,
  required Color color,
  required String creditNumber,
  required String expire,
  required String name,
}) {
  return Container(
    padding: EdgeInsets.all(20),
    margin: EdgeInsets.only(left: 16.0, right: 16, bottom: 16, top: 16),
    decoration: boxDecoration(
        radius: 20,
        backGroundColor: color,
        spreadRadius: 4.0,
        blurRadius: 10.0,
        shadowColor: color.withAlpha(50)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  'images/orapay/opchip.png',
                  height: 40,
                  width: 40,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    visaTitle,
                    style: boldTextStyle(size: 22, textColor: Colors.white,letterSpacing: 2,wordSpacing: 2),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            FittedBox(
              child: Text(
                "**** **** **** " + creditNumber,
                style: boldTextStyle(
                    size: 20,
                    textColor: Colors.white,
                    letterSpacing: 3,
                    wordSpacing: 2),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 15),
          ],
        ),
        Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FittedBox(
                    child: Text(
                      'CARDHOLDER',
                      style: secondaryTextStyle(textColor: Colors.white60),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FittedBox(
                    child: Text(
                      name,
                      style: primaryTextStyle(textColor: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FittedBox(
                    child: Text(
                      'EXPIRES',
                      style: secondaryTextStyle(textColor: Colors.white60),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  FittedBox(
                    child: Text(
                      expire,
                      style: primaryTextStyle(textColor: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              SizedBox(),
            ],
          ),
        ),
      ],
    ),
  );
}

getAppBar(title, {showBack = true, required GestureTapCallback pressed}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
//        showBack
//            ? InkWell(
//          onTap: pressed,
//          child: Container(
//            margin: EdgeInsets.only(left: 16),
//            height: 45,
//            width: 45,
//            decoration: BoxDecoration(
//              color: Color(0xFFE7E6F3),
//              borderRadius: BorderRadius.all(
//                Radius.circular(16),
//              ),
//            ),
//            child: Icon(
//              Icons.keyboard_backspace,
//              color: opPrimaryColor,
//            ),
//          ),
//        )
//            : SizedBox(),
        SizedBox(
          width: 16.0,
        ),
        Center(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

getAppBar1(title, {actions, leading}) {
  return AppBar(
    leading: leading,
    title: Text(
      title,
      style: TextStyle(color: Colors.black, fontSize: 22, fontFamily: fontBold),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    centerTitle: false,
    automaticallyImplyLeading: false,
    actions: actions,
  );
}

// ignore: non_constant_identifier_names
Widget SliderButton({Color? color, String title = '', required VoidCallback onPressed}) {
  return RaisedButton(
      padding: EdgeInsets.only(left: 16, right: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0),
        side: BorderSide(color: Colors.transparent),
      ),
      color: color,
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      onPressed: () {
        onPressed();
      });
}

Widget oPDotIndicator({required bool isActive}) {
  return AnimatedContainer(
    duration: Duration(milliseconds: 150),
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    height: isActive ? 10.0 : 8.0,
    width: isActive ? 10.0 : 8.0,
    decoration: BoxDecoration(
      color: isActive ? opPrimaryColor : Colors.grey.withOpacity(0.5),
      borderRadius: BorderRadius.all(Radius.circular(50)),
    ),
  );
}

Widget SliderPage(
    {final Size? size, String? image, required String title, String? description}) {
  return Column(
    children: <Widget>[
      Container(
        child: Image(
          image: AssetImage(image!),
          height: size!.width,
          width: size.height,
        ),
      ),
      SizedBox(height: 4),
      Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40),
          child: Text(title,
              textAlign: TextAlign.center, style: boldTextStyle(size: 18,wordSpacing: 2,letterSpacing: 2)),
        ),
      ),
      SizedBox(height: 15.0),
      Padding(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Text(description!,
            textAlign: TextAlign.center, style: secondaryTextStyle()),
      )
    ],
    crossAxisAlignment: CrossAxisAlignment.start,
  );
}
