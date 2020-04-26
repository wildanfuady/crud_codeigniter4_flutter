import 'package:flutter_crud_ci4/model/user.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class UserApiService {

  final String baseUrl = "http://192.168.43.245/belajar-codeigniter-4/crud_ci4_flutter/ci4_restapi_flutter/public/index.php/";
  Client client = Client();

  Future<List<User>> getUsers() async {
    final response = await client.get("$baseUrl/user");
    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      return [];
    }
  }

  Future<bool> createUser(User data) async {
    final response = await client.post(
      "$baseUrl/user/create",
      body: {
        "fullname" : data.fullName,
        "grade" : data.grade,
        "gender" : data.gender,
        "phone" : data.phone 
      }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<User> getUserBy(int id) async {
    final response = await client.get("$baseUrl/user/getUserBy/$id");
    if (response.statusCode == 200) {
      final data = User.fromJson(json.decode(response.body));
      return data;
    } else {
      return null;
    }
  }

  Future<bool> updateUser({int id, User data}) async {
    final response = await client.post(
      "$baseUrl/user/update/$id",
      body: {
        "fullname" : data.fullName,
        "grade" : data.grade,
        "gender" : data.gender,
        "phone" : data.phone 
      }
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

}