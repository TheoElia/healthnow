import 'dart:core';

import 'package:flutter/material.dart';
import 'package:healthnowapp/src/models/models.dart';
import 'package:healthnowapp/src/network/network_utils.dart';
import 'package:healthnowapp/src/screens/chatscreen.dart';

Future<List<CategoryModel>?> getCategories() async {
  var result = await handleResponse(
      await getRequest('/api/v1/services/fetch-all-categories/'));

  Iterable list = result['objects'];
  return list.map((model) => CategoryModel.fromJson(model)).toList();
}

Future<List<ProfessionalModel>?> getCategoryDoctors(int categoryId) async {
  var body = {'q': categoryId};
  var result = await handleResponse(
      await postRequest('/api/v1/services/search-by-category/', body));

  Iterable list = result['objects'];
  return list.map((model) => ProfessionalModel.fromJson(model)).toList();
}

<<<<<<< HEAD
Future<bool?> sendRequest(String text, int id, double fee,int userId) async {
=======
Future<List<MessageModel>?> getNewMsg() (int senderId, int reciepientId, String msg) async {
  var body = {'sender_id': senderId, 'reciepient_id', 'message':msg};
  var result = await handleResponse(
      await postRequest('/api/v1/services/get-messages/', body));

  Iterable list = result['objects'];
  return list.map((model) => MessgeModel.fromJson(model)).toList();
}

Future<String?> sendRequest(String text, int id, double fee,int userId) async {
>>>>>>> 336e6c68b3e9a75d72c79d78c3c47cb91eb6c087
  var body = {'problem': text,'patient':userId,'professional':id,'fee':fee};
  var result = await handleResponse(
      await postRequest('/api/v1/services/create-request/', body));
  String message = result['message'];
  Future<bool?> success = result['success'];
  return success;
}

Future<String?> sendMessage(int senderId, int reciepientId, String msg) async {
  var body = {'sender_id': senderId, 'reciepient_id', 'message':msg};
  var result = await handleResponse(
      await postRequest('/api/v1/services/send-message/', body));

  String message = result['message'];
  return message;
}
