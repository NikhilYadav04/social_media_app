// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media/styling/sizeConfig.dart';
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
                  size: 3.792148*SizeConfig.heightMultiplier,
                ),
              ),
              playerErrorFallback: Center(
                child: Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 3.792148*SizeConfig.heightMultiplier,
                ),
              ),
            ),
          ),

          //* Upper Icons
          FractionallySizedBox(
            heightFactor: 0.1,
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.2321*SizeConfig.widthMultiplier),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.purple.shade800),
                          fixedSize: WidgetStatePropertyAll(Size(11.1607*SizeConfig.widthMultiplier, 5.26685*SizeConfig.heightMultiplier))),
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
                              ? WidgetStatePropertyAll(Size(26.785*SizeConfig.widthMultiplier, 5.26685*SizeConfig.heightMultiplier))
                              : WidgetStatePropertyAll(Size(22.3214*SizeConfig.widthMultiplier, 5.26685*SizeConfig.heightMultiplier))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.high_quality,
                            color: Colors.white,
                            size: 3.1601*SizeConfig.heightMultiplier,
                          ),
                          SizedBox(
                            width: 1.116*SizeConfig.widthMultiplier,
                          ),
                          FittedBox(
                            child: Text(
                              widget.isHome ? "1080p" : widget.quality,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 2.1067*SizeConfig.heightMultiplier,
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
              padding: EdgeInsets.symmetric(horizontal: 2.232*SizeConfig.widthMultiplier),
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
                        fontSize: 2.73877*SizeConfig.heightMultiplier),
                  ),
                  SizedBox(
                    height: 0.84269*SizeConfig.heightMultiplier,
                  ),
                  Text(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    "By ${widget.videoCreator}",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                        fontSize: 2.4227*SizeConfig.heightMultiplier),
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
              padding: EdgeInsets.symmetric(horizontal: 2.232*SizeConfig.widthMultiplier),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.purple.shade800),
                          fixedSize: WidgetStatePropertyAll(Size(40.17857*SizeConfig.widthMultiplier, 5.2668*SizeConfig.heightMultiplier))),
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
                                fontSize: 2.31742*SizeConfig.heightMultiplier,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      )),
                  IconButton(
                      style: ButtonStyle(
                          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                          backgroundColor: WidgetStatePropertyAll(Colors.red),
                          fixedSize: WidgetStatePropertyAll(Size(31.25*SizeConfig.widthMultiplier, 5.2668*SizeConfig.heightMultiplier))),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.white,
                            size: 3.16012*SizeConfig.imageSizeMultiplier,
                          ),
                          SizedBox(
                            width: 2.0089*SizeConfig.widthMultiplier,
                          ),
                          Text(
                            "2 Likes",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 2.31742*SizeConfig.heightMultiplier,
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
