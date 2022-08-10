import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  final baseUrl = "https://arcane-eyrie-42068.herokuapp.com/api/";

  postData(data, apiUrl) async {
    var fullUrl = Uri.parse(baseUrl + apiUrl);
    return http.post(fullUrl, body: jsonEncode(data), headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    });
  }

  logout() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    var fullUrl = Uri.parse(baseUrl + 'logout');
    return http.post(fullUrl, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
  }

  getData(data, apiUrl) async {
    var fullUrl = (baseUrl + apiUrl) as Uri;
    return http.get(fullUrl, headers: {
      "Accept": "application/json",
      "Content-Type": "application/json"
    });
  }
}
