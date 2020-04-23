import 'package:flutter_crud_ci4/model/user.dart';
import 'package:http/http.dart' show Client;

class UserApiService {

  final String baseUrl = "http://192.168.43.245/belajar-codeigniter-4/ci4_restapi_flutter/public/index.php/";
  Client client = Client();

  Future<List<User>> getUsers() async {
    final response = await client.get("$baseUrl/user");
    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      return null;
    }
  }

}