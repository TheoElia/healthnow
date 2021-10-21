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

Future<bool?> sendRequest(String text, int id, double fee,int userId) async {
  var body = {'problem': text,'patient':userId,'professional':id,'fee':fee};
  var result = await handleResponse(
      await postRequest('/api/v1/services/create-request/', body));
  String message = result['message'];
  Future<bool?> success = result['success'];
  return success;
}

Future<String?> sendMessage(int senderId, int recipientId, String msg) async {
  var body = {'sender_id': senderId ?? 13, 'recipient_id':recipientId, 'message':msg};
  var result = await handleResponse(
      await postRequest('/api/v1/services/create-message/', body));

  String message = result['message'];
  return message;
}

Future<List<MessageModel>?> getNewMsg(senderId) async {
  var body = {'id': senderId ?? 13};
  var result = await handleResponse(
      await postRequest('/api/v1/services/read-message/', body));

  Iterable list = result['objects'];
  return list.map((model) => MessageModel.fromJson(model)).toList();
}
