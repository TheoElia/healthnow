import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthnowapp/src/models/models.dart';
import 'package:healthnowapp/src/network/config.dart';
import 'package:healthnowapp/src/screens/dashboard_screen.dart';

class DoctorsInfo extends StatefulWidget {
  final ProfessionalModel doctor;

  const DoctorsInfo({Key? key, required this.doctor}) : super(key: key);
  @override
  _DoctorsInfoState createState() => _DoctorsInfoState();
}

class _DoctorsInfoState extends State<DoctorsInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.10,
              ),
              Row(
                children: <Widget>[
                  Image.network("$baseURL${widget.doctor.userImage}",
                      height: 220),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 222,
                    height: 220,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${widget.doctor.firstName}",
                          style: TextStyle(fontSize: 32),
                        ),
                        Text(
                          "${widget.doctor.category.name}",
                          style: TextStyle(fontSize: 19, color: Colors.grey),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ButtonTheme(
                          minWidth: 100.0,
                          child: RaisedButton(
                            child: Text(
                              'Book',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                            onPressed: () {},
                            color: Color(0xFFef3131),
                            textColor: Colors.white,
                            padding: EdgeInsets.all(15),
                            splashColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(color: Color(0xFFef3131)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 26,
              ),
              Text(
                "About",
                style: TextStyle(fontSize: 22),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "${widget.doctor.about}",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
              SizedBox(
                height: 24,
              ),
//               Row(
//                 children: <Widget>[
//                   Column(
//                     children: <Widget>[
// //                       Row(
// //                         children: <Widget>[
// //                           Image.asset("assets/images/mappin.png"),
// //                           SizedBox(
// //                             width: 20,
// //                           ),
// //                           Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: <Widget>[
// //                               Text(
// //                                 "Address",
// //                                 style: TextStyle(
// //                                     color: Colors.black87.withOpacity(0.7),
// //                                     fontSize: 20),
// //                               ),
// //                               SizedBox(
// //                                 height: 3,
// //                               ),
// //                               Container(
// //                                   width:
// //                                       MediaQuery.of(context).size.width - 268,
// //                                   child: Text(
// //                                     "House # 2, Pearl Street, Accra",
// //                                     style: TextStyle(color: Colors.grey),
// //                                   ))
// //                             ],
// //                           )
// //                         ],
// //                       ),
// //                       SizedBox(
// //                         height: 20,
// //                       ),
// //                       Row(
// //                         children: <Widget>[
// //                           Image.asset("assets/images/clock.png"),
// //                           SizedBox(
// //                             width: 20,
// //                           ),
// //                           Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: <Widget>[
// //                               Text(
// //                                 "Time",
// //                                 style: TextStyle(
// //                                     color: Colors.black87.withOpacity(0.7),
// //                                     fontSize: 20),
// //                               ),
// //                               SizedBox(
// //                                 height: 3,
// //                               ),
// //                               Container(
// //                                   width:
// //                                       MediaQuery.of(context).size.width - 268,
// //                                   child: Text(
// //                                     '''Monday - Friday
// // Open till 7 Pm''',
// //                                     style: TextStyle(color: Colors.grey),
// //                                   ))
// //                             ],
// //                           )
// //                         ],
// //                       )
// //                     ],
// //                   ),
// //                   Image.asset(
// //                     "assets/images/map.png",
// //                     width: 180,
// //                   )
// //                 ],
// //               ),

              Text(
                "Activity",
                style: TextStyle(
                    color: Color(0xff242424),
                    fontSize: 28,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 22,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                      decoration: BoxDecoration(
                          color: Color(0xffFBB97C),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Color(0xffFCCA9B),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Image.asset("assets/images/list.png")),
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2 - 130,
                            child: Text(
                              "Rating\n ${widget.doctor.rating}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                      decoration: BoxDecoration(
                          color: Color(0xffA5A5A5),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Color(0xffBBBBBB),
                                  borderRadius: BorderRadius.circular(16)),
                              child: Image.asset("assets/images/list.png")),
                          SizedBox(
                            width: 16,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 2 - 130,
                            child: Text(
                              "Reviews\n ${widget.doctor.appointments}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 17),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class IconTile extends StatelessWidget {
  final String imgAssetPath;
  final Color backColor;

  IconTile({required this.imgAssetPath, required this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6),
      child: Container(
        height: 45,
        width: 45,
        decoration: BoxDecoration(
            color: backColor, borderRadius: BorderRadius.circular(15)),
        child: Image.asset(
          imgAssetPath,
          width: 20,
        ),
      ),
    );
  }
}
