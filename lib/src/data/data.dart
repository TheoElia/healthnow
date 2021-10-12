import 'package:flutter/cupertino.dart';
import 'package:healthnowapp/src/models/speciality.dart';

List<SpecialityModel> getSpeciality() {
  List<SpecialityModel> specialities = [
    SpecialityModel(
        backgroundColor: Color(0xffFBB97C),
        imgAssetPath: "assets/images/img1.png",
        noOfDoctors: 10,
        speciality: "Cough & Cold"),
    SpecialityModel(
        backgroundColor: Color(0xffF69383),
        imgAssetPath: "assets/images/img2.png",
        noOfDoctors: 17,
        speciality: "Heart Specialist"),
    SpecialityModel(
        backgroundColor: Color(0xffEACBCB),
        imgAssetPath: "assets/images/img3.png",
        noOfDoctors: 27,
        speciality: "Diabetes Care"),
  ];

  return specialities;
}
