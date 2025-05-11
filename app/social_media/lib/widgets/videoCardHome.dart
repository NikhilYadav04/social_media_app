import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_media/styling/sizeConfig.dart';

Widget videoCardHome(
    String title, String uploadedAt, String videoCreator, String videoURL) {
  return SizedBox(
    height: 34.7613 * SizeConfig.heightMultiplier,
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
            borderRadius:
                BorderRadius.circular(1.053 * SizeConfig.heightMultiplier),
          ),
          child: CachedNetworkImage(
            imageUrl: videoURL,
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
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
                  bottomLeft:
                      Radius.circular(1.264 * SizeConfig.heightMultiplier),
                  bottomRight:
                      Radius.circular(1.264 * SizeConfig.heightMultiplier),
                ),
                color: Colors.grey.shade900),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 1.67410 * SizeConfig.widthMultiplier,
                  vertical: 0.8426 * SizeConfig.heightMultiplier),
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
                        fontSize: 1.89608 * SizeConfig.heightMultiplier),
                  ),
                  SizedBox(
                    height: 1.2640 * SizeConfig.heightMultiplier,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.purple.shade100,
                        size: 2.1067 * SizeConfig.heightMultiplier,
                      ),
                      SizedBox(
                        width: 2.6785 * SizeConfig.widthMultiplier,
                      ),
                      Text(
                        uploadedAt,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.purple.shade100,
                            fontWeight: FontWeight.w500,
                            fontSize: 1.7907 * SizeConfig.heightMultiplier),
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
                  size: 2.1067*SizeConfig.imageSizeMultiplier,
                ),
                SizedBox(
                  width: 1.116*SizeConfig.widthMultiplier,
                ),
                Text(
                  videoCreator,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 1.685399*SizeConfig.heightMultiplier,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
            height: 3.16012*SizeConfig.heightMultiplier,
            width: 17.857*SizeConfig.widthMultiplier,
          ),
        ),
      ],
    ),
  );
}
