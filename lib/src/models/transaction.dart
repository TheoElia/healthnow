import 'dart:convert';
import 'package:healthnowapp/src/services/webservice.dart';

class Transaction {
  String id;
  String transactionId;
  double amount;
  bool completed;
  String transactionType;
  String account;
  String status;

  Transaction(
      {required this.id,
      required this.transactionId,
      required this.completed,
      required this.transactionType,
      required this.account,
      required this.status,
      required this.amount});

  factory Transaction.fromJson(dynamic json) {
    return Transaction(
        id: json['id'] as String,
        transactionId: json['transaction_id'] as String,
        amount: json['amount'] as double,
        completed: json['completed'] as bool,
        transactionType: json['transaction_type'] as String,
        account: json['account'] as String,
        status: json['status'] as String);
  }

  static Resource<List> get all {
    return Resource(
        url: 'https://healthnow.pywe.org/api/v1/accounts/get-transactions/',
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
    return '{${this.id}, ${this.transactionId}, ${this.transactionType}, ${this.amount}, ${this.status},${this.account},${this.completed} }';
  }
}
