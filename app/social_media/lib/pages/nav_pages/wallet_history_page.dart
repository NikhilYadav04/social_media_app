// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:social_media/helper/shared_pref.dart';

import 'package:social_media/styling/colors.dart';
import 'package:social_media/styling/sizeConfig.dart';

class WalletHistoryPage extends StatefulWidget {
  final List<dynamic> balance_history;
  WalletHistoryPage({
    Key? key,
    required this.balance_history,
  }) : super(key: key);

  @override
  State<WalletHistoryPage> createState() => _WalletHistoryPageState();
}

class _WalletHistoryPageState extends State<WalletHistoryPage> {
  String name = "";
  void getName() async {
    name = await LocalStorageFunctions.getName() ?? "Dummy";
    setState(() {
      name;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorsApp.backgroundColor,
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: ColorsApp.backgroundColor,
                toolbarHeight: 7.90028*SizeConfig.heightMultiplier,
                centerTitle: true,
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 4.00282*SizeConfig.heightMultiplier,
                    )),
                title: Text(
                  'Wallet History',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 3.58146*SizeConfig.heightMultiplier),
                ),
              ),
            ];
          },
          body: ListView.builder(
              itemCount: widget.balance_history.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.6785*SizeConfig.widthMultiplier, vertical: 0.8426*SizeConfig.heightMultiplier),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 3.3482*SizeConfig.widthMultiplier, vertical: 0.526*SizeConfig.heightMultiplier),
                    minTileHeight: 8.95368*SizeConfig.heightMultiplier,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(1.053*SizeConfig.heightMultiplier),
                        side: BorderSide(
                            color: Color.fromARGB(255, 189, 167, 247),
                            width: 2)),
                    tileColor: Color.fromARGB(255, 32, 32, 32),
                    leading: CircleAvatar(
                      radius: 2.949*SizeConfig.heightMultiplier,
                      backgroundColor: Colors.purple.shade600,
                      child: Center(
                        child: FittedBox(
                          child: Text(
                            "₹${widget.balance_history[index]["amountCredited"]}",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 2.1067*SizeConfig.heightMultiplier),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      "Credited By : ${name}",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 2.422*SizeConfig.heightMultiplier),
                    ),
                    subtitle: Text(
                      widget.balance_history[index]["creditedAt"],
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 1.8960*SizeConfig.heightMultiplier),
                    ),
                    trailing: TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.purple.shade600),
                            shape: WidgetStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1.5800*SizeConfig.heightMultiplier),
                              ),
                            )),
                        onPressed: () {},
                        child: Icon(
                          Icons.attach_money,
                          color: Colors.white,
                          size: 2.73877*SizeConfig.heightMultiplier,
                        )),
                  ),
                );
              })),
    ));
  }
}
