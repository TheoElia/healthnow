import 'package:flutter/cupertino.dart';
import 'package:healthnowapp/src/models/models.dart';
import 'package:healthnowapp/src/network/network_utils.dart';

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
