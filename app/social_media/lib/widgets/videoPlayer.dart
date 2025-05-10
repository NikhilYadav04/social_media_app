// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

import 'package:social_media/styling/colors.dart';

// ignore: must_be_immutable
class Videoplayer extends StatefulWidget {
  bool isHome;
  String title;
  String quality;
  String videoCreator;
  String videoURL;
  Videoplayer({
    Key? key,
    required this.isHome,
    required this.title,
    required this.quality,
    required this.videoCreator,
    required this.videoURL,
  }) : super(key: key);

  @override
  State<Videoplayer> createState() => _VideoplayerState();
}

class _VideoplayerState extends State<Videoplayer> {
  late FlickManager _flickManager;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // ignore: deprecated_member_use
    final controller = VideoPlayerController.network(widget.videoURL);

    _flickManager = FlickManager(videoPlayerController: controller);

    _initializeVideoPlayerFuture = controller.initialize().then((_) {
      controller.play();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorsApp.backgroundColor,
      body: Stack(
        fit: StackFit.expand,
        children: [
          //* Video Widget

          FlickVideoPlayer(
            flickManager: _flickManager,
            flickVideoWithControls: FlickVideoWithControls(
              aspectRatioWhenLoading: 9 / 16,
              playerLoadingFallback: Center(
                child: SpinKitCircle(
                  color: Colors.purple.shade800,
                  size: 36,
                ),
              ),
              playerErrorFallback: Center(
                child: Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 36,
                ),
              ),
            ),
          ),

          //* Upper Icons
          FractionallySizedBox(
            heightFactor: 0.1,
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.purple.shade800),
                          fixedSize: WidgetStatePropertyAll(Size(50, 50))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 34,
                        ),
                      )),
                  IconButton(
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.purple.shade800),
                          fixedSize: widget.isHome
                              ? WidgetStatePropertyAll(Size(120, 50))
                              : WidgetStatePropertyAll(Size(100, 50))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.high_quality,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          FittedBox(
                            child: Text(
                              widget.isHome ? "1080p" : widget.quality,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          )
                        ],
                      ))
                ],
              ),
            ),
          ),

          //* Title and creator

          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.25,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    widget.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 26),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    "By ${widget.videoCreator}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 23),
                  ),
                ],
              ),
            ),
          )

          //* Bottom Buttons
          ,
          FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.12,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.purple.shade800),
                          fixedSize: WidgetStatePropertyAll(Size(180, 50))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "20.0₹  1 Tipper",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      )),
                  IconButton(
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                          backgroundColor: WidgetStatePropertyAll(Colors.red),
                          fixedSize: WidgetStatePropertyAll(Size(140, 50))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,
                            size: 30,
                          ),
                          SizedBox(
                            width: 9,
                          ),
                          Text(
                            "2 Likes",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ))
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
