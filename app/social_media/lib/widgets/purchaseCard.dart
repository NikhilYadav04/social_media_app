import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media/services/accountService.dart';
import 'package:social_media/styling/colors.dart';
import 'package:social_media/styling/sizeConfig.dart';

List<String> quality = ["240p", "360p", "720p", "1080p"];

List<String> price = ["₹20", "₹40", "₹60", "₹80"];

Map<String, num> priceMap = {
  "₹20": 20,
  "₹40": 40,
  "₹60": 60,
  "₹80": 80,
};

Widget purchaseCard(num balance, String title, String uploadedAt,
    String videoCreator, String videoURL) {
  return Container(
    color: ColorsApp.backgroundColor,
    child: Column(
      children: [
        SizedBox(
          height: 1.264*SizeConfig.heightMultiplier,
        ),
        Center(
          child: Text(
            "Purchase Video Quality",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 3.16012*SizeConfig.heightMultiplier),
          ),
        ),
        SizedBox(
          height: 1.5800*SizeConfig.heightMultiplier,
        ),
        ElevatedButton.icon(
          style: ButtonStyle(
              fixedSize: WidgetStatePropertyAll(Size(51.339*SizeConfig.widthMultiplier, 5.793*SizeConfig.heightMultiplier)),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.053*SizeConfig.heightMultiplier))),
              backgroundColor: WidgetStatePropertyAll(Colors.purple.shade800)),
          onPressed: () {},
          label: Text(
            "Balance : ₹${balance}",
            style: TextStyle(color: Colors.white, fontSize: 2.1067*SizeConfig.heightMultiplier),
          ),
          icon: Icon(
            Icons.account_balance_wallet,
            color: Colors.white,
            size:3.160*SizeConfig.heightMultiplier,
          ),
        ),
        SizedBox(
          height: 2.1067*SizeConfig.heightMultiplier,
        ),
        SizedBox(
          height: 36.8681*SizeConfig.heightMultiplier,
          child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.11607*SizeConfig.widthMultiplier, vertical: 0.526687*SizeConfig.heightMultiplier),
                  child: ListTile(
                    minTileHeight: 7.9002*SizeConfig.heightMultiplier,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.053*SizeConfig.heightMultiplier),
                        side: BorderSide(
                            color: Colors.purple.shade800, width: 2)),
                    tileColor: Color.fromARGB(255, 32, 32, 32),
                    title: Text(
                      quality[index],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 2.52809*SizeConfig.heightMultiplier),
                    ),
                    subtitle: Text(
                      "Unlock This Quality",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 1.89607*SizeConfig.heightMultiplier),
                    ),
                    trailing: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.purple.shade800),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1.58006*SizeConfig.heightMultiplier),
                              ),
                            )),
                        onPressed: () async {
                          //* Purchase Video

                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          //* Check if user has bought this quality
                                          color: Colors.purple.shade800,
                                          width: 3),
                                      borderRadius: BorderRadius.circular(1.053*SizeConfig.heightMultiplier)),
                                  backgroundColor: ColorsApp.backgroundColor,
                                  content: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 1.053*SizeConfig.heightMultiplier, horizontal: 3.34821*SizeConfig.widthMultiplier),
                                    height: 12.64049*SizeConfig.heightMultiplier,
                                    width: 40.1785*SizeConfig.widthMultiplier,
                                    decoration: BoxDecoration(
                                        color: ColorsApp.backgroundColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      children: [
                                        SpinKitCircle(
                                          color: Colors.purple.shade800,
                                          size: 4.424*SizeConfig.heightMultiplier,
                                        ),
                                        SizedBox(height: 2.106*SizeConfig.heightMultiplier),
                                        Center(
                                          child: FittedBox(
                                            child: Text(
                                              "Purchasing Video...",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 3.3707*SizeConfig.heightMultiplier),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              });
                          // await Future.delayed(Duration(seconds: 5));

                          await Accountservice.purchaseVideo(
                              context,
                              title,
                              videoURL,
                              uploadedAt,
                              quality[index],
                              priceMap[price[index]]!,
                              videoCreator);

                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          price[index],
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize:2.1067*SizeConfig.heightMultiplier),
                        )),
                  ),
                );
              }),
        )
      ],
    ),
  );
}
