// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media/services/videoServices.dart';
import 'package:social_media/styling/sizeConfig.dart';
import 'package:video_player/video_player.dart';
import 'package:social_media/styling/colors.dart';

// ignore: must_be_immutable
class UploadPageDetail extends StatefulWidget {
  File? videoFIle;
  UploadPageDetail({
    Key? key,
    this.videoFIle,
  }) : super(key: key);

  @override
  State<UploadPageDetail> createState() => _UploadPageDetailState();
}

class _UploadPageDetailState extends State<UploadPageDetail> {
  final TextEditingController _titleController = TextEditingController();

  late FlickManager _flickManager;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final controller = VideoPlayerController.file(widget.videoFIle!);
    _flickManager = FlickManager(videoPlayerController: controller);
    _initializeVideoPlayerFuture = controller.initialize().then((_) {
      controller.play();
      setState(() {});
    });
  }

  @override
  void dispose() {
    _flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: ColorsApp.backgroundColor,
            resizeToAvoidBottomInset: true,
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    bottom: PreferredSize(
                        preferredSize: Size.fromHeight(5),
                        child: Divider(
                          color: Colors.purple.shade700,
                          thickness: 5,
                        )),
                    automaticallyImplyLeading: false,
                    backgroundColor: ColorsApp.backgroundColor,
                    toolbarHeight: 8.95368*SizeConfig.heightMultiplier,
                    actions: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.upload,
                            color: Colors.white,
                            size: 4.002810*SizeConfig.heightMultiplier,
                          )),
                    ],
                    title: Text(
                      'Upload Video',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 3.5814619*SizeConfig.heightMultiplier),
                    ),
                  ),
                ];
              },
              body: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 1.053*SizeConfig.heightMultiplier, horizontal: 2.67857*SizeConfig.widthMultiplier),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: ColorsApp.backgroundColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Video Preview : ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 3.370798*SizeConfig.heightMultiplier),
                          ),
                          SizedBox(
                            height: 2.10681*SizeConfig.heightMultiplier,
                          ),

                          //* DIsplay Video
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.053*SizeConfig.heightMultiplier, horizontal: 1.7857*SizeConfig.widthMultiplier),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ColorsApp.backgroundColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //* Display Video
                                SizedBox(
                                  height: 35.8147*SizeConfig.heightMultiplier,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(0.8426*SizeConfig.heightMultiplier), // Optional
                                    child: FutureBuilder(
                                      future: _initializeVideoPlayerFuture,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return FlickVideoPlayer(
                                            flickManager: _flickManager,
                                          );
                                        } else {
                                          return  Center(
                                            child: SpinKitFadingCube(
                                              color: ColorsApp.backgroundColor,
                                              size: 3.7921*SizeConfig.heightMultiplier,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 1.58006*SizeConfig.heightMultiplier,
                          ),
                          Text(
                            "Video Title : ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 3.370787*SizeConfig.heightMultiplier),
                          ),
                          SizedBox(
                            height: 2.1067*SizeConfig.heightMultiplier,
                          ),
                          //* Search Field
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1.2640*SizeConfig.heightMultiplier),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                      color: Colors.grey.shade100)
                                ]),
                            height: 6.32022*SizeConfig.heightMultiplier,
                            child: TextField(
                              style: TextStyle(
                                  color: Colors.grey.shade200, fontSize: 2.3174*SizeConfig.heightMultiplier),
                              controller: _titleController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 3.16012*SizeConfig.heightMultiplier,
                                  color: Colors.grey.shade200,
                                ),
                                label: Text(
                                  "Enter Your Video Title",
                                  style: TextStyle(
                                      color: Colors.grey.shade200,
                                      fontSize: 2.3174*SizeConfig.heightMultiplier),
                                ),
                                filled: true,
                                fillColor: ColorsApp.backgroundColor,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(1.2640*SizeConfig.heightMultiplier),
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(1.2640*SizeConfig.heightMultiplier),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(1.2640*SizeConfig.heightMultiplier),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 15.8006*SizeConfig.heightMultiplier,
                          ),

                          _isLoading
                              ? SpinKitCircle(
                                  color: Colors.purple.shade800,
                                  size:3.792*SizeConfig.heightMultiplier,
                                )
                              : Center(
                                  child: ElevatedButton.icon(
                                      icon: Icon(
                                        Icons.upload,
                                        color: Colors.white,
                                        size: 4.00282*SizeConfig.heightMultiplier,
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Colors.purple.shade700),
                                          shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(1.5800*SizeConfig.heightMultiplier)),
                                          ),
                                          fixedSize: WidgetStatePropertyAll(
                                              Size(100.446*SizeConfig.widthMultiplier, 6.8469*SizeConfig.heightMultiplier))),
                                      onPressed: () async {
                                        //* Upload
                                        setState(() {
                                          _isLoading = true;
                                        });

                                        await Videoservices.uploadVideos(
                                            context,
                                            widget.videoFIle!,
                                            _titleController.text.toString());

                                        setState(() {
                                          _isLoading = false;
                                        });

                                        Navigator.of(context).pop();
                                      },
                                      label: Text(
                                        "Upload",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 2.94944*SizeConfig.heightMultiplier,
                                            fontWeight: FontWeight.w600),
                                      )),
                                )
                        ],
                      )),
                ],
              ),
            )));
  }
}
