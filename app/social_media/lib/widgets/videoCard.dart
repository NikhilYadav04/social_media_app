import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media/styling/sizeConfig.dart';
import 'package:social_media/widgets/logger_glob.dart';
import 'package:social_media/widgets/purchaseCard.dart';

Widget videoCard(
  BuildContext context,
  String title,
  String date,
  String videoCreator,
  num balance,
  String videoURl,
  VoidCallback onClose,
) {
  printLog(videoURl);
  return SizedBox(
    height: 34.7613*SizeConfig.heightMultiplier,
    child: Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 189, 167, 247),
                  spreadRadius: 2,
                  blurRadius: 2)
            ],
            borderRadius: BorderRadius.circular(1.053*SizeConfig.heightMultiplier),
          ),
          child: CachedNetworkImage(
            imageUrl: videoURl,
            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        FractionallySizedBox(
          heightFactor: 0.4,
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(1.2640*SizeConfig.heightMultiplier),
                  bottomRight: Radius.circular(1.2640*SizeConfig.heightMultiplier),
                ),
                color: Colors.grey.shade900),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 1.6741*SizeConfig.widthMultiplier, vertical: 0.84269*SizeConfig.heightMultiplier),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 1.8960*SizeConfig.heightMultiplier),
                  ),
                  SizedBox(
                    height: 1.264*SizeConfig.heightMultiplier,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.purple.shade100,
                        size: 2.1067*SizeConfig.heightMultiplier,
                      ),
                      SizedBox(
                        width:2.678*SizeConfig.widthMultiplier,
                      ),
                      Text(
                        date,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.purple.shade100,
                            fontWeight: FontWeight.w500,
                            fontSize: 1.7907*SizeConfig.heightMultiplier),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.purple.shade800.withOpacity(0.8),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 2.1067*SizeConfig.heightMultiplier,
                ),
                SizedBox(
                  width: 1.11607*SizeConfig.widthMultiplier,
                ),
                Text(
                  videoCreator,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 1.685399*SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            height: 3.1601 * SizeConfig.heightMultiplier,
            width: 17.857 * SizeConfig.widthMultiplier,
          ),
        ),
        FractionallySizedBox(
          heightFactor: 0.55,
          child: Center(
            child: Column(
              children: [
                Icon(
                  Icons.lock,
                  color: Colors.white,
                  size: 3.7921481*SizeConfig.heightMultiplier,
                ),
                SizedBox(
                  height: 0.52668,
                ),
                TextButton(
                    style: ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size(22.3214*SizeConfig.widthMultiplier, 4.74018*SizeConfig.heightMultiplier)),
                        backgroundColor: WidgetStatePropertyAll(
                            Colors.purple.shade800),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1.5800*SizeConfig.heightMultiplier),
                          ),
                        )),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(1.053*SizeConfig.heightMultiplier),
                                topRight: Radius.circular(1.053*SizeConfig.heightMultiplier),
                              ),
                              child: FractionallySizedBox(
                                heightFactor: 1,
                                child: purchaseCard(balance, title, date,
                                    videoCreator, videoURl),
                              ),
                            );
                          }).then((_) {
                        onClose();
                      });
                    },
                    child: Center(
                      child: Text(
                        "Unlock",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 2.1067*SizeConfig.heightMultiplier),
                      ),
                    )),
              ],
            ),
          ),
        )
      ],
    ),
  );
}
