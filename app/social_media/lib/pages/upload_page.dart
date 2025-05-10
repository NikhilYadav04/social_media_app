import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media/pages/nav_pages/upload_page_detail.dart';
import 'package:social_media/services/cloudinaryServices.dart';
import 'package:social_media/styling/colors.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: ColorsApp.backgroundColor,
              toolbarHeight: 75,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.upload,
                      color: Colors.white,
                      size: 38,
                    )),
              ],
              title: Text(
                'Upload Page',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 34),
              ),
            ),
          ];
        },
        body: Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(bottom: 100),
            height: 380,
            width: 390,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color(0xFFB36A5E), blurRadius: 7, spreadRadius: 4),
                BoxShadow(
                    color: Color(0xFF6E59A5), blurRadius: 7, spreadRadius: 4),
              ],
              color: Color.fromARGB(255, 53, 51, 51),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 35),
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.purple.shade700,
                      radius: 45,
                      child: Center(
                        child: Icon(
                          Icons.upload,
                          color: Colors.white,
                          size: 56,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Upload Your Video",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  FittedBox(
                    child: Text(
                      "Share your videos with your followers",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 21,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        //* Pick video
                        File? videoFile =
                            await CloudinaryServices.pickVideo("Camera");
                        if (videoFile != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => UploadPageDetail(videoFIle: videoFile,),
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.purple.shade700),
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                          fixedSize: WidgetStatePropertyAll(Size(180, 60))),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            "Select Video",
                            style: TextStyle(color: Colors.white, fontSize: 23),
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
