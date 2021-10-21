import 'dart:convert';
import 'package:healthnowapp/src/services/webservice.dart';

class Order {
  String id;
  String message;
  int patient;
  String patientUsername;
  String proUsername;
  double fee;
  bool paid;
  bool accepted;
  bool declined;
  bool attendedTo;
  String meetingLink;
  double rating;
  String status;
  String review;


  Order(
      {required this.id,
      required this.message,
      required this.patient,
      required this.patientUsername,
      required this.proUsername,
      required this.fee,
      required this.paid,
      required this.accepted,
      required this.declined,
      required this.attendedTo,
      required this.meetingLink,
      required this.rating,
      required this.status,
      required this.review});

  factory Order.fromJson(dynamic json) {
    return Order(
        id: json['id'] as String,
        message: json['message'] as String,
        patient: json['patient'] as int,
        patientUsername: json['patient_username'] as String,
        proUsername: json['professional_username'] as String,
        fee: json['consultation_fee'] as double,
        paid: json['paid'] as bool,
        accepted: json['accepted'] as bool,
        declined: json['declined'] as bool,
        attendedTo: json['attended_to'] as bool,
        meetingLink: json['meeting_link'] as String,
        rating: json['rating'] as double,
        status: json['status'] as String,
        review: json['delivered'] as String);
  }

  static Resource<List> get all {
    return Resource(
        url: 'https://healthnow.pywe.org/api/v1/services/get-requests/',
        parse: (response) {
          final result = json.decode(response.body);
          print(result);
          Iterable list = result['objects'];
          List<dynamic> pending = [];
          // print(result['objects']);
          for (var element in list) {
            pending.add(element);
          }
          return pending;
        });
  }

  @override
  String toString() {
    return '{${this.id}, ${this.id}, ${this.patient}, ${this.patientUsername},${this.proUsername}, ${this.paid}, ${this.fee},${this.paid},${this.accepted},${this.declined},${this.attendedTo},${this.review},${this.status},${this.meetingLink},${this.message},${this.rating} }';
  }
}
