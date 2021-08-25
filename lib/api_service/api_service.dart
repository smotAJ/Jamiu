import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:jamiu_flutter/models/user_model.dart';

class ApiService {
  final endPointUrl = "jamiu-task-manager.herokuapp.com";
  final client = http.Client();
  var dbUserData = Hive.box('userData');

  Future<Response> createUser(String name, email, phoneNumber, password) async {
    List<UserModel> userModel = [];
    late Response response;
    try {
      final uri = Uri.https(endPointUrl, '/users');
      var data = {
        "email": email,
        "password": password,
        "name": name,
        "phoneNumber": phoneNumber
      };
      var encoded = jsonEncode(data);

      response = await client.post(uri, body: encoded, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      var jsonBody = json.decode(response.body);

      String tokenJson = jsonBody['token'];
      String nameJson = jsonBody['user']['name'];
      String emailJson = jsonBody['user']['email'];
      int ageJson = jsonBody['user']['age'];
      String _idJson = jsonBody['user']['_id'];

      print("Apiservice: $nameJson");

      userModel.add(UserModel(
          age: ageJson,
          id: _idJson,
          email: emailJson,
          name: nameJson,
          accessToken: tokenJson));

      dbUserData.put('userData', userModel);

      return response;
    } catch (er) {
      print("Exception $er");
      return response;
    }
  }

  Future<Response> loginUser(String email, password) async {
    List<UserModel> userModel = [];
    late Response response;
    try {
      final uri = Uri.https(endPointUrl, '/users/login');
      var data = {"email": email, "password": password};
      var encoded = jsonEncode(data);

      response = await client.post(uri, body: encoded, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      var jsonBody = json.decode(response.body);

      String tokenJson = jsonBody['token'];

      String nameJson = jsonBody['user']['name'];
      String emailJson = jsonBody['user']['email'];
      int ageJson = jsonBody['user']['age'];
      String _idJson = jsonBody['user']['_id'];

      print("Apiservice: $nameJson");

      userModel.add(UserModel(
          age: ageJson,
          id: _idJson,
          email: emailJson,
          name: nameJson,
          accessToken: tokenJson));

      dbUserData.put('userData', userModel);

      return response;
    } catch (er) {
      print("Exception $er");
      return response;
    }
  }
}
