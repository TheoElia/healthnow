import 'package:flutter/material.dart';
import 'package:healthnowapp/src/data/data.dart';
import 'package:healthnowapp/src/models/models.dart';
import 'package:healthnowapp/src/screens/dashboard_screen.dart';
import 'package:healthnowapp/src/screens/doctor_info_screen.dart';
import 'package:nb_utils/nb_utils.dart';

class DoctorList extends StatefulWidget {
  final int categoryId;
  const DoctorList({Key? key, required this.categoryId}) : super(key: key);

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  late List<ProfessionalModel>? doctors;
  @override
  void initState() {
    super.initState();
    doctors=getCategoryDoctors(widget.categoryId) as List<ProfessionalModel>?;
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
          child: Wrap(
            runSpacing: 8,
            spacing: 8,
            children: doctors!.map((e) {
              return GestureDetector(
                onTap: () {
                  DoctorsInfo(
                    doctor: e,
                  ).launch(context);
                },
                child: DoctorsTile( doctor: e,
                ),
              );
            }).toList(),
          ).center(),
        ),
      ),
    );
  }
}
