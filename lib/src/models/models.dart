import 'dart:convert';

import 'package:flutter/cupertino.dart';

class SpecialityModel {
  String imgAssetPath;
  String speciality;
  int noOfDoctors;
  Color backgroundColor;
  SpecialityModel(
      {required this.imgAssetPath,
      required this.speciality,
      required this.noOfDoctors,
      required this.backgroundColor});
}

class CategoryModel {
  int id;
  String name;
  String image;
  double fee;
  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.fee,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'fee': fee,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      fee: map['fee'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(Map<String, dynamic> source) => CategoryModel.fromMap(source);
}

class ProfessionalModel {
  int id;
  String username;
  String firstName;
  String lastName;
  bool isPro;
  String userImage;
  String location;
  int appointments;
  CategoryModel category;
  ProfessionalModel({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.isPro,
    required this.userImage,
    required this.location,
    required this.appointments,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'isPro': isPro,
      'userImage': userImage,
      'location': location,
      'appointments': appointments,
      'category': category.toMap(),
    };
  }

  factory ProfessionalModel.fromMap(Map<String, dynamic> map) {
    return ProfessionalModel(
      id: map['id'],
      username: map['username'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      isPro: map['isPro'],
      userImage: map['userImage'],
      location: map['location'],
      appointments: map['appointments'],
      category: CategoryModel.fromMap(map['category']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfessionalModel.fromJson(Map<String, dynamic> source) => ProfessionalModel.fromMap(source);
}
