import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media/helper/api_endpoints.dart';
import 'package:social_media/helper/shared_pref.dart';
import 'package:http/http.dart' as http;
import 'package:social_media/pages/auth/login_page.dart';
import 'package:social_media/services/authServices.dart';
import 'package:social_media/services/cloudinaryServices.dart';
import 'package:social_media/widgets/toast.dart';

class Videoservices {
  //* upload videos
  static Future<void> uploadVideos(
      BuildContext context, File videoFile, String title) async {
    try {
      final videoURL =
          await CloudinaryServices.uploadVideoToCloudinary(videoFile);

      if (videoURL == "Failed") {
        toastErrorSlide(context, "Error Uploading Video");
        return;
      }

      final id = await LocalStorageFunctions.getUserID();
      final token = await LocalStorageFunctions.getToken();
      final name = await LocalStorageFunctions.getName();


      final req_body = {
        "userId": id,
        "videoURL": videoURL,
        "title": title,
        "videoCreator": name
      };

      final url2 = await Uri.parse(ApiEndpoints.videoUpload);

      final response =
          await http.post(url2, body: jsonEncode(req_body), headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      final response_body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        toastSuccessSlide(context, "Video Uploaded Successfully");
        return;
      } else if (response.statusCode == 401) {
        //* if user session is user
        if (response_body["message"] == "jwt expired") {
          logoutUser();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
          return;
        }
      } else {
        toastErrorSlide(context, "Video Upload Failed");
        return;
      }
    } catch (e) {
      print(e.toString());
      toastErrorSlide(context, "Video Upload Failed");
      return;
    }
  }

  //* get videos ( purchased and user uploaded)
  static Future<List<dynamic>> getPUVideos(BuildContext context) async {
    try {
      final id = await LocalStorageFunctions.getUserID();
      final token = await LocalStorageFunctions.getToken();

      final url = await Uri.parse(ApiEndpoints.videosByUser(id!));

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

  //* get videos of following accounts
  static Future<List<dynamic>> getFollowingVideos(BuildContext context) async {
    try {
      final id = await LocalStorageFunctions.getUserID();

      final token = await LocalStorageFunctions.getToken();

      final url = await Uri.parse(ApiEndpoints.videosFollowing(id!));

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

  Videoservices._();
}
