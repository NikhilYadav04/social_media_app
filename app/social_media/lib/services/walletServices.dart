import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social_media/helper/api_endpoints.dart';
import 'package:social_media/helper/shared_pref.dart';
import 'package:social_media/pages/auth/login_page.dart';
import 'package:social_media/services/authServices.dart';
import 'package:social_media/widgets/toast.dart';

class Walletservices {
  //* recharge wallet
  static Future<void> rechargeWallet(BuildContext context, num amount) async {
    try {
      final id = await LocalStorageFunctions.getUserID();
      final token = await LocalStorageFunctions.getToken();

      final url = await Uri.parse(ApiEndpoints.walletRecharge);

      final req_body = {"amount": amount, "id": id};

      final response =
          await http.post(url, body: jsonEncode(req_body), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      final response_body = jsonDecode(response.body);

      //* if user session is user
      if (response_body["message"] == "jwt expired") {
        logoutUser();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      }

      if (response.statusCode == 200) {
        toastSuccessSlide(context, "Recharge Successful");
        return;
      } else if (response.statusCode == 401) {
        //* if user session is user
        if (response_body["message"] == "jwt expired") {
          logoutUser();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
        return;
      } else {
        toastErrorSlide(context, response_body["message"]);
        return;
      }
    } catch (e) {
      toastSuccessSlide(context, "Recharge Failed");
      print(e.toString());
      return;
    }
  }

  //* get balance
  static Future<List<dynamic>> getBalance(BuildContext context) async {
    try {
      final id = await LocalStorageFunctions.getUserID();
      final token = await LocalStorageFunctions.getToken();

      final url = await Uri.parse(ApiEndpoints.walletBalance(id!));

      final response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
      });

      final response_body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return response_body;
      } else if (response.statusCode == 401) {
        //* if user session is user
        if (response_body["message"] == "jwt expired") {
          logoutUser();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
        return [];
      } else {
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Walletservices._();
}
