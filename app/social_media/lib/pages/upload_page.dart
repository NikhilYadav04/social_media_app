import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media/pages/nav_pages/upload_page_detail.dart';
import 'package:social_media/services/cloudinaryServices.dart';
import 'package:social_media/styling/colors.dart';
import 'package:social_media/styling/sizeConfig.dart';

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
              automaticallyImplyLeading: false,
              backgroundColor: ColorsApp.backgroundColor,
              toolbarHeight: 7.9002*SizeConfig.heightMultiplier,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.upload,
                      color: Colors.white,
                      size: 4.0028*SizeConfig.heightMultiplier,
                    )),
              ],
              title: Text(
                'Upload Page',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 3.58146*SizeConfig.heightMultiplier),
              ),
            ),
          ];
        },
        body: Align(
          alignment: Alignment.center,
          child: Container(
            margin: EdgeInsets.only(bottom: 10.533*SizeConfig.heightMultiplier),
            height: 40.028*SizeConfig.heightMultiplier,
            width: 87.053*SizeConfig.widthMultiplier,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color(0xFFB36A5E), blurRadius: 7, spreadRadius: 4),
                BoxShadow(
                    color: Color(0xFF6E59A5), blurRadius: 7, spreadRadius: 4),
              ],
              color: Color.fromARGB(255, 53, 51, 51),
              borderRadius: BorderRadius.circular(1.264*SizeConfig.heightMultiplier),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 3.68679*SizeConfig.heightMultiplier),
              child: Column(
                children: [
                  Center(
                    child: CircleAvatar(
                      backgroundColor: Colors.purple.shade700,
                      radius: 4.74017*SizeConfig.heightMultiplier,
                      child: Center(
                        child: Icon(
                          Icons.upload,
                          color: Colors.white,
                          size: 5.89887*SizeConfig.heightMultiplier,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 2.6334*SizeConfig.heightMultiplier,
                  ),
                  Text(
                    "Upload Your Video",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 3.3707*SizeConfig.heightMultiplier,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 0.8426*SizeConfig.heightMultiplier,
                  ),
                  FittedBox(
                    child: Text(
                      "Share your videos with your followers",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 2.212*SizeConfig.heightMultiplier,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 2.633427*SizeConfig.heightMultiplier,
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
                              borderRadius: BorderRadius.circular(2.106742*SizeConfig.heightMultiplier))),
                          fixedSize: WidgetStatePropertyAll(Size(40.1785*SizeConfig.widthMultiplier, 6.320246*SizeConfig.heightMultiplier))),
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            "Select Video",
                            style: TextStyle(color: Colors.white, fontSize: 2.4227*SizeConfig.heightMultiplier),
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
