import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:social_media/services/accountService.dart';
import 'package:social_media/styling/colors.dart';

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
          height: 12,
        ),
        Center(
          child: Text(
            "Purchase Video Quality",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w700, fontSize: 30),
          ),
        ),
        SizedBox(
          height: 15,
        ),
        ElevatedButton.icon(
          style: ButtonStyle(
              fixedSize: WidgetStatePropertyAll(Size(230, 55)),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
              backgroundColor: WidgetStatePropertyAll(Colors.purple.shade800)),
          onPressed: () {},
          label: Text(
            "Balance : ₹${balance}",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          icon: Icon(
            Icons.account_balance_wallet,
            color: Colors.white,
            size: 30,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 350,
          child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: ListTile(
                    minTileHeight: 75,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: Colors.purple.shade800, width: 2)),
                    tileColor: Color.fromARGB(255, 32, 32, 32),
                    title: Text(
                      quality[index],
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    subtitle: Text(
                      "Unlock This Quality",
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    trailing: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.purple.shade800),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
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
                                      borderRadius: BorderRadius.circular(10)),
                                  backgroundColor: ColorsApp.backgroundColor,
                                  content: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 15),
                                    height: 120,
                                    width: 180,
                                    decoration: BoxDecoration(
                                        color: ColorsApp.backgroundColor,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      children: [
                                        SpinKitCircle(
                                          color: Colors.purple.shade800,
                                          size: 42,
                                        ),
                                        SizedBox(height: 20),
                                        Center(
                                          child: FittedBox(
                                            child: Text(
                                              "Purchasing Video...",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 32),
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
                              fontSize: 20),
                        )),
                  ),
                );
              }),
        )
      ],
    ),
  );
}
