import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_media/helper/api_endpoints.dart';
import 'package:social_media/helper/shared_pref.dart';

class CloudinaryServices {
  static final ImagePicker _picker = ImagePicker();

  //* record or pick video
  static Future<File?> pickVideo(String source) async {
    final status = await [
      Permission.camera,
      Permission.microphone,
      Permission.storage,
    ].request();

    if (status.values.any((s) => !s.isGranted)) {
      return null;
    }

    final XFile? videoFile = await _picker.pickVideo(
      source: source == "Camera" ? ImageSource.camera : ImageSource.gallery,
      maxDuration: const Duration(minutes: 5),
    );

    if (videoFile == null) {
      return null;
    } else {
      return File(videoFile.path);
    }
  }

  //* upload video to cloud

  static Future<String?> uploadVideoToCloudinary(File videoFile) async {
    final uri = Uri.parse(ApiEndpoints.cloudinaryURL);
    final token = await LocalStorageFunctions.getToken();

    try {
      final request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath(
          'videos', // <--- this must match the multer field name
          videoFile.path,
          contentType: MediaType('video', 'mp4'),
        ));

      request.headers['Authorization'] = 'Bearer $token';

      final response = await request.send();

      if (response.statusCode == 200) {
        final resStr = await response.stream.bytesToString();
        final resJson = json.decode(resStr);
        return resJson['secure_url'];
      } else {
        print('Upload failed: ${response.statusCode}');
        return "Failed";
      }
    } catch (e) {
      print('Error uploading video: $e');
      return "Failed";
    }
  }

  CloudinaryServices._();
}
