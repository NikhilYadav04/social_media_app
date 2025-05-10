import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:social_media/helper/api_endpoints.dart';
import 'package:http/http.dart' as http;
import 'package:social_media/helper/shared_pref.dart';
import 'package:social_media/pages/auth/login_page.dart';
import 'package:social_media/pages/root_page.dart';
import 'package:social_media/widgets/toast.dart';

//* logout
Future<void> logoutUser() async {
  await LocalStorageFunctions.storeEmail("");
  await LocalStorageFunctions.storeName("");
  await LocalStorageFunctions.storeToken("");
  await LocalStorageFunctions.storeUserID("");
  await LocalStorageFunctions.storeAuth(false);
}

class Authservice {
  //* register
  static Future<void> registerUser(
      BuildContext context, String name, String email, String password) async {
    try {
      final url = Uri.parse(ApiEndpoints.register);
      final req_body = {"name": name, "email": email, "password": password};

      final response = await http.post(url,
          body: jsonEncode(req_body),
          headers: {'Content-Type': 'application/json'});
      final response_body = jsonDecode(response.body);

      if (response.statusCode == 201) {
        toastSuccessSlide(context, "Account Created Successfully");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else if (response.statusCode == 401) {
        toastErrorSlide(context, response_body["message"]);
      } else {
        toastErrorSlide(context, response_body["message"][0]["message"]);
      }

      return;
    } catch (e) {
      print('Error : ${e.toString()}');
      return;
    }
  }

  //* login
  static Future<void> loginUser(
      BuildContext context, String email, String password) async {
    try {
      final url = Uri.parse(ApiEndpoints.login);
      final req_body = {"email": email, "password": password};

      final response = await http.post(url,
          body: jsonEncode(req_body),
          headers: {'Content-Type': 'application/json'});
      final response_body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        //* set the values
        await LocalStorageFunctions.storeAuth(true);
        await LocalStorageFunctions.storeEmail(response_body["email"]);
        await LocalStorageFunctions.storeName(response_body["name"]);
        await LocalStorageFunctions.storeUserID(response_body["id"]);
        await LocalStorageFunctions.storeToken(response_body["token"]);

        toastSuccessSlide(context, "Account Login Successfully");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RootPage()),
        );
      } else if (response.statusCode == 401) {
        toastErrorSlide(context, response_body["message"]);
      } else {
        toastErrorSlide(context, response_body["message"][0]["message"]);
      }

      return;
    } catch (e) {
      print('Error : ${e.toString()}');
      return;
    }
  }

  //* check status
  static Future<bool> checkStatus() async{
     return await LocalStorageFunctions.getAuth() ?? false;
  }

  Authservice._();
}
