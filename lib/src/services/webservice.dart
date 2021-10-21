import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:healthnowapp/src/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Resource<T> {
  final String url;
  T Function(Response response) parse;

  Resource({required this.url, required this.parse});
}

class Webservice {
  Future<T> load<T>(Resource<T> resource) async {
    final pref = await SharedPreferences.getInstance();
    final k = 'uuid';
    final myuid = pref.getString(k) ?? '0';
    print(myuid);
    Map<String, String> requestHeaders = {
      // 'Content-type': 'application/json',
      'Accept': 'application/json',
      // 'Token':'AAAAIl3GvqE:APA91bEJ3NkSzL6YrdyTfuEVXJPSjgve5qs_h3cX8MA82mrU2HetPRxf_',
      // 'KeyCode': myuid
    };
    final prefs = await SharedPreferences.getInstance();
    final key = 'user';
    final user = prefs.getString(key) ?? '0';
    User myuser = User.fromJson(user);
    final response = await http.post(Uri.parse(resource.url),
        headers: requestHeaders, body: jsonEncode({'username': myuser.username}));
    if (response.statusCode == 200) {
      return resource.parse(response);
    } else {
      throw Exception('Failed to load data!');
    }
  }
}
