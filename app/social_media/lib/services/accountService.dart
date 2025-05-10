import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:social_media/helper/api_endpoints.dart';
import 'package:social_media/helper/shared_pref.dart';
import 'package:http/http.dart' as http;
import 'package:social_media/pages/auth/login_page.dart';
import 'package:social_media/services/authServices.dart';
import 'package:social_media/widgets/toast.dart';

class Accountservice {
  //* get account details
  static Future<List<dynamic>> getAccountDetails(BuildContext context) async {
    try {
      final id = await LocalStorageFunctions.getUserID();
      final token = await LocalStorageFunctions.getToken();

      final url = await Uri.parse(ApiEndpoints.accountInfo(id!));

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

  //* purchase video
  static Future<void> purchaseVideo(
      BuildContext context,
      String title,
      String videoURL,
      String uploadedAt,
      String videoQuality,
      num videoPrice,
      String videoCreator) async {
    try {
      final id = await LocalStorageFunctions.getUserID();
      final token = await LocalStorageFunctions.getToken();

      final url = await Uri.parse(ApiEndpoints.accountPurchase);

      final req_body = {
        "id": id,
        "title": title,
        "videoURL": videoURL,
        "videoQuality": videoQuality,
        "uploadedAt": uploadedAt,
        "videoPrice": videoPrice,
        "videoCreator": videoCreator,
        "upVotes": 0,
        "tip": 0
      };

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
        toastSuccessSlide(context,
            "Video purchased Successfully, go to purchased section under profile page to watch the videos.");
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
      toastErrorSlide(context, "Error in purchasing video");
      print(e.toString());
      return;
    }
  }

  //* follow or unfollow
  static Future<void> followORunfollow(BuildContext context, String userName,
      String followName, String status) async {
    try {
      final token = await LocalStorageFunctions.getToken();

      final url = await Uri.parse(ApiEndpoints.accountFollow);

      final req_body = {
        "userName": userName,
        "followName": followName,
        "status": status
      };

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
        if (status == "Follow") {
          toastSuccessSlide(context, "Account Followed successfully");
        } else {
          toastSuccessSlide(context, "Account UnFollowed successfully");
        }

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
        toastErrorSlide(context, "Cannot do this action");
        return;
      }
    } catch (e) {
      toastErrorSlide(context, "Cannot do this action");
      print(e.toString());
      return;
    }
  }

  //* search for accounts
  static Future<List<dynamic>> searchAccounts(
      BuildContext context, String id) async {
    try {
      final token = await LocalStorageFunctions.getToken();

      final url = await Uri.parse(ApiEndpoints.accountSearch(id));

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

  Accountservice._();
}
