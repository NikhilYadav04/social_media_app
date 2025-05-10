import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    height: 330,
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
            borderRadius: BorderRadius.circular(10),
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
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                color: Colors.grey.shade900),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.5, vertical: 8),
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
                        fontSize: 18),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        color: Colors.purple.shade100,
                        size: 20,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        date,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: Colors.purple.shade100,
                            fontWeight: FontWeight.w500,
                            fontSize: 17),
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
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  videoCreator,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            height: 30,
            width: 80,
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
                  size: 36,
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                    style: ButtonStyle(
                        fixedSize: WidgetStatePropertyAll(Size(100, 45)),
                        backgroundColor: WidgetStatePropertyAll(
                            Colors.purple.shade800.withOpacity(0.8)),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        )),
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
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
                            fontSize: 20),
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
