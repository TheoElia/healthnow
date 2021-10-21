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
  String color;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.fee,
    required this.color,
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
      color: map['color'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(Map<String, dynamic> source) =>
      CategoryModel.fromMap(source);
}

class ProfessionalModel {
  int id;
  String username;
  String firstName;
  String lastName;
  String about;
  bool isPro;
  double rating;
  String userImage;
  String location;
  int appointments;
  CategoryModel category;
  ProfessionalModel({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.about,
    required this.rating,
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
      'about': about,
      'rating': rating,
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
      firstName: map['first_name'],
      lastName: map['last_name'],
      about: map['about'],
      rating: map['rating'],
      isPro: map['is_professional'],
      userImage: map['user_image'],
      location: map['location'],
      appointments: map['appointments'],
      category: CategoryModel.fromMap(map['category']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfessionalModel.fromJson(Map<String, dynamic> source) =>
      ProfessionalModel.fromMap(source);
}

class MessageModel {
  int? msgId;
  String senderId;
  String receiverId;
  String msg;
  // String time;

  MessageModel({
    this.msgId,
    required this.senderId,
    required this.receiverId,
    required this.msg,
  });

  Map<String, dynamic> toMap() {
    return {
      'msgId': msgId,
      'senderId': senderId,
      'receiverId': receiverId,
      'msg': msg,
      // 'time': time,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      msgId: map['msgId'],
      senderId: map['sender'],
      receiverId: map['recipient'],
      msg: map['message'],
      // time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(Map<String, dynamic> source) =>
      MessageModel.fromMap(source);
}
