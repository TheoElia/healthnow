import 'package:flutter/material.dart';

import 'package:healthnowapp/src/data/data.dart';
import 'package:healthnowapp/src/models/models.dart';
import 'package:healthnowapp/src/screens/doctor_info_screen.dart';
import 'package:healthnowapp/src/screens/doctorlist_screen.dart';
import 'package:healthnowapp/src/widgets/drawer.dart';
import 'package:nb_utils/src/extensions/widget_extensions.dart';

String selectedCategorie = "Adults";

class DashBoard extends StatefulWidget {
  final List<CategoryModel>? categories;
  const DashBoard({
    Key? key,
    required this.categories,
  }) : super(key: key);
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyDrawer ddrawer = MyDrawer();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      // drawer: Drawer(child: Container() // Populate the Drawer in the next step.
      //     ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Text(
                "Welcome to \nHealthNow",
                style: TextStyle(
                    color: Colors.black87.withOpacity(0.8),
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 40,
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 24),
              //   height: 50,
              //   decoration: BoxDecoration(
              //       color: Color(0xffEFEFEF),
              //       borderRadius: BorderRadius.circular(14)),
              //   child: Row(
              //     children: <Widget>[
              //       Icon(Icons.search),
              //       SizedBox(
              //         width: 10,
              //       ),
              //       Text(
              //         "Search",
              //         style: TextStyle(color: Colors.grey, fontSize: 19),
              //       )
              //     ],
              //   ),
              // ),
              // SizedBox(
              //   height: 30,
              // ),
              Text(
                "Categories",
                style: TextStyle(
                    color: Colors.black87.withOpacity(0.8),
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              // Container(
              //   height: 30,
              //   child: ListView.builder(
              //       itemCount: widget.categories.length,
              //       shrinkWrap: true,
              //       physics: ClampingScrollPhysics(),
              //       scrollDirection: Axis.horizontal,
              //       itemBuilder: (context, index) {
              //         return CategorieTile(
              //           categorie: widget.categories[index],
              //           isSelected: selectedCategorie == widget.categories[index],
              //           context: this,
              //         );
              //       }),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              Container(
                height: 250,
                child: ListView.builder(
                    itemCount: widget.categories!.length,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          DoctorList(
                            categoryId: widget.categories![index].id,
                          ).launch(context);
                        },
                        child: SpecialistTile(
                          imgAssetPath: widget.categories![index].image,
                          speciality: widget.categories![index].name,
                          fee: widget.categories![index].fee,
                          backColor: Color(0xfff69383),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Recent Appointment",
                style: TextStyle(
                    color: Colors.black87.withOpacity(0.8),
                    fontSize: 25,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Most recent appointment shows here',
                style: TextStyle(fontSize: 17, color: Colors.grey),
              )
              // DoctorsTile(doctor: null,)
            ],
          ),
        ),
      ),
      drawer: ddrawer,
    );
  }
}

class CategorieTile extends StatefulWidget {
  final String categorie;
  final bool isSelected;
  _DashBoardState context;
  CategorieTile(
      {required this.categorie,
      required this.isSelected,
      required this.context});

  @override
  _CategorieTileState createState() => _CategorieTileState();
}

class _CategorieTileState extends State<CategorieTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.context.setState(() {
          selectedCategorie = widget.categorie;
        });
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(left: 8),
        height: 30,
        decoration: BoxDecoration(
            color: widget.isSelected ? Color(0xFFef3131) : Colors.white,
            borderRadius: BorderRadius.circular(30)),
        child: Text(
          widget.categorie,
          style: TextStyle(
              color: widget.isSelected ? Colors.white : Color(0xffA1A1A1)),
        ),
      ),
    );
  }
}

class SpecialistTile extends StatelessWidget {
  final String imgAssetPath;
  final String speciality;
  final double fee;
  final Color backColor;
  SpecialistTile(
      {required this.imgAssetPath,
      required this.speciality,
      required this.fee,
      required this.backColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
          color: backColor, borderRadius: BorderRadius.circular(24)),
      padding: EdgeInsets.only(top: 16, right: 16, left: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            speciality,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            height: 6,
          ),
          Text(
            "GHC $fee",
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
          Image.network(
            'https://healthnow.pywe.org${imgAssetPath}',
            height: 160,
            fit: BoxFit.fitHeight,
          )
        ],
      ),
    );
  }
}

class DoctorsTile extends StatelessWidget {
  final ProfessionalModel doctor;

  const DoctorsTile({Key? key, required this.doctor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffFFEEE0), borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      child: Row(
        children: <Widget>[
          Image.network(
            "https://healthnow.pywe.org${doctor.userImage}",
            height: 50,
          ),
          SizedBox(
            width: 17,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${doctor.firstName}",
                style: TextStyle(color: Color(0xFFef3131), fontSize: 19),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                "${doctor.category.name}",
                style: TextStyle(fontSize: 15),
              )
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
            decoration: BoxDecoration(
                color: Color(0xFFef3131),
                borderRadius: BorderRadius.circular(13)),
            child: Text(
              "View",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}
