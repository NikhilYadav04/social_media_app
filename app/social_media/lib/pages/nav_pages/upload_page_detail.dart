// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media/services/videoServices.dart';
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
                    toolbarHeight: 85,
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
                      'Upload Video',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 34),
                    ),
                  ),
                ];
              },
              body: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12),
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
                                fontSize: 32),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          //* DIsplay Video
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: ColorsApp.backgroundColor,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //* Display Video
                                SizedBox(
                                  height: 340,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.circular(8), // Optional
                                    child: FutureBuilder(
                                      future: _initializeVideoPlayerFuture,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return FlickVideoPlayer(
                                            flickManager: _flickManager,
                                          );
                                        } else {
                                          return const Center(
                                            child: SpinKitFadingCube(
                                              color: ColorsApp.backgroundColor,
                                              size: 36,
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
                            height: 15,
                          ),
                          Text(
                            "Video Title : ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 32),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          //* Search Field
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                      color: Colors.grey.shade100)
                                ]),
                            height: 60,
                            child: TextField(
                              style: TextStyle(
                                  color: Colors.grey.shade200, fontSize: 22),
                              controller: _titleController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  size: 30,
                                  color: Colors.grey.shade200,
                                ),
                                label: Text(
                                  "Enter Your Video Title",
                                  style: TextStyle(
                                      color: Colors.grey.shade200,
                                      fontSize: 22),
                                ),
                                filled: true,
                                fillColor: ColorsApp.backgroundColor,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: Colors.black)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),

                          SizedBox(
                            height: 150,
                          ),

                          _isLoading
                              ? SpinKitCircle(
                                  color: Colors.purple.shade800,
                                  size: 36,
                                )
                              : Center(
                                  child: ElevatedButton.icon(
                                      icon: Icon(
                                        Icons.upload,
                                        color: Colors.white,
                                        size: 38,
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Colors.purple.shade700),
                                          shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                          fixedSize: WidgetStatePropertyAll(
                                              Size(450, 65))),
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
                                            fontSize: 28,
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
