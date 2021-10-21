

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthnowapp/src/data/data.dart';
// import 'package:healthnowapp/src/data/data.dart';
import 'package:healthnowapp/src/models/models.dart';
import 'package:healthnowapp/src/screens/dashboard_screen.dart';
import 'package:healthnowapp/src/screens/doctor_info_screen.dart';
// import 'package:healthnowapp/src/screens/login.dart';
import 'package:healthnowapp/src/screens/register.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nb_utils/src/extensions/widget_extensions.dart';

class DoctorList extends StatefulWidget {
  final int categoryId;
  const DoctorList({Key? key, required this.categoryId}) : super(key: key);

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  List<ProfessionalModel>? doctors = [];
  bool loading = false;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    setState(() {
      loading = true;
    });
    doctors = await getCategoryDoctors(widget.categoryId);
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: const Text("Doctors",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: GestureDetector(
          onTap: () {
            finish(context);
          },
          child: const Icon(Icons.arrow_back, color: blackColor),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: loading
              ? CupertinoActivityIndicator().center()
              : Wrap(
                  runSpacing: 8,
                  spacing: 8,
                  children: doctors!.map((e) {
                    return GestureDetector(
                      onTap: () {
                        checkRegistered(e);
                      },
                      child: DoctorsTile(
                        doctor: e,
                      ),
                    );
                  }).toList(),
                ).center(),
        ),
      ),
    );
  }

  void checkRegistered(ProfessionalModel e) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('category', e.category.id);
    String? user = prefs.getString('user');
    if (user == null) {
      Register().launch(context);
    } else {
      DoctorsInfo(
        doctor: e,
      ).launch(context);
    }
  }
}
