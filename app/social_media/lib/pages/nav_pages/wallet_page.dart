import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:social_media/pages/nav_pages/wallet_history_page.dart';
import 'package:social_media/services/walletServices.dart';
import 'package:social_media/styling/colors.dart';
import 'package:social_media/styling/sizeConfig.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final TextEditingController _amountController = TextEditingController();

  num balance = 0;
  String updatedAt = "";
  List balance_history = [];
  bool _isFetching = false;
  bool _isRecharge = false;

  Future<void> fetchBalance() async {
    setState(() {
      _isFetching = true;
    });
    final price_list = await Walletservices.getBalance(context);
    setState(() {
      balance = price_list[0]["balance"];
      balance_history = price_list[0]["history"];
      updatedAt = price_list[0]["lastUpdated"];
      _isFetching = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchBalance();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: ColorsApp.backgroundColor,
      body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
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
                  'Wallet',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 3.58147*SizeConfig.heightMultiplier),
                ),
              ),
            ];
          },
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.6785*SizeConfig.widthMultiplier),
            child: Column(
              children: [
                SizedBox(
                  height: 1.26404*SizeConfig.heightMultiplier,
                ),
                Skeletonizer(
                  enabled: _isFetching,
                  child: Container(
                    height: 23.17423*SizeConfig.heightMultiplier,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.26404*SizeConfig.heightMultiplier),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFB36A5E), // soft warm brown
                            Color(0xFF6E59A5), // your provided purple
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0xFFB36A5E),
                              blurRadius: 5,
                              spreadRadius: 2),
                          BoxShadow(
                              color: Color(0xFF6E59A5),
                              blurRadius: 5,
                              spreadRadius: 2),
                        ]),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.1067*SizeConfig.heightMultiplier, horizontal: 3.34821*SizeConfig.widthMultiplier),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Your Balance",
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 2.52809*SizeConfig.heightMultiplier,
                                    fontWeight: FontWeight.w500),
                              ),
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                color: Colors.white,
                                size: 2.94948*SizeConfig.heightMultiplier,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 0.52668*SizeConfig.heightMultiplier,
                          ),
                          Text(
                            "₹$balance",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 5.477547*SizeConfig.heightMultiplier,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 1.053*SizeConfig.heightMultiplier,
                          ),
                          ElevatedButton.icon(
                              label: FittedBox(
                                child: Text(
                                  "Last updated : $updatedAt",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 2.1067*SizeConfig.heightMultiplier),
                                ),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      Colors.purple.shade700),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0.52668*SizeConfig.heightMultiplier))),
                                  fixedSize:
                                      WidgetStatePropertyAll(Size(63.6160*SizeConfig.widthMultiplier, 5.26687*SizeConfig.heightMultiplier))),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => WalletHistoryPage(
                                      balance_history: balance_history,
                                    ),
                                  ),
                                );
                              },
                              icon: Icon(
                                Icons.history,
                                color: Colors.white,
                                size: 2.42276*SizeConfig.heightMultiplier,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height:3.68681*SizeConfig.heightMultiplier,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 1.5800*SizeConfig.heightMultiplier, horizontal: 3.125*SizeConfig.widthMultiplier),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 53, 51, 51),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(1.264*SizeConfig.heightMultiplier),
                            topRight: Radius.circular(1.264*SizeConfig.heightMultiplier))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recharge Wallet",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 3.47613*SizeConfig.heightMultiplier,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 0.84269*SizeConfig.heightMultiplier,
                        ),
                        Text(
                          "Enter amount to add to your wallet",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 2.31742*SizeConfig.heightMultiplier,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 2.94944*SizeConfig.heightMultiplier,
                        ),

                        //* Search Field
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1.264*SizeConfig.heightMultiplier),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    color: Colors.grey.shade100)
                              ]),
                          height:6.3202*SizeConfig.heightMultiplier,
                          child: TextField(
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                                color: Colors.grey.shade200, fontSize:2.3174*SizeConfig.heightMultiplier),
                            controller: _amountController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.currency_rupee,
                                size: 3.16012*SizeConfig.heightMultiplier,
                                color: Colors.grey.shade200,
                              ),
                              label: Text(
                                "Enter Amount To Recharge",
                                style: TextStyle(
                                    color: Colors.grey.shade200, fontSize: 2.3174*SizeConfig.heightMultiplier),
                              ),
                              filled: true,
                              fillColor: ColorsApp.backgroundColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(1.264*SizeConfig.heightMultiplier),
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(1.264*SizeConfig.heightMultiplier),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(1.264*SizeConfig.heightMultiplier),
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 2.94944*SizeConfig.heightMultiplier,
                        ),
                        Text(
                          "Quick Select : ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 2.317*SizeConfig.heightMultiplier,
                              fontWeight: FontWeight.w600),
                        ),

                        SizedBox(
                          height: 1.7907*SizeConfig.heightMultiplier,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            amountButton(50, _amountController),
                            amountButton(100, _amountController),
                            amountButton(200, _amountController),
                            amountButton(500, _amountController),
                          ],
                        ),

                        SizedBox(
                          height: 16.8539*SizeConfig.heightMultiplier,
                        ),

                        _isRecharge
                            ? SpinKitCircle(
                                color: Colors.purple.shade800,
                              )
                            : TextButton(
                                style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        Colors.purple.shade700),
                                    fixedSize:
                                        WidgetStatePropertyAll(Size(89.285*SizeConfig.widthMultiplier, 6.3202*SizeConfig.heightMultiplier)),
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(1.053*SizeConfig.heightMultiplier)))),
                                onPressed: () async {
                                  //* Recharge Wallet
                                  setState(() {
                                    _isRecharge = true;
                                  });

                                  await Walletservices.rechargeWallet(
                                      context,
                                      int.parse(
                                          _amountController.text.toString()));
                                  await fetchBalance();

                                  setState(() {
                                    _isRecharge = false;
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    "Recharge Now",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 2.73877*SizeConfig.heightMultiplier,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ))
                      ],
                    ),
                  ),
                ))
              ],
            ),
          )),
    ));
  }
}

Widget amountButton(num value, TextEditingController _amountController) {
  return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.purple.shade700),
          fixedSize: WidgetStatePropertyAll(Size(20.0892*SizeConfig.widthMultiplier, 5.2670*SizeConfig.heightMultiplier)),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.526*SizeConfig.heightMultiplier)))),
      onPressed: () {
        _amountController.text = value.toString();
      },
      child: Center(
        child: FittedBox(
          child: Text(
            "₹$value",
            style: TextStyle(
                color: Colors.white, fontSize: 1.89607*SizeConfig.heightMultiplier, fontWeight: FontWeight.w700),
          ),
        ),
      ));
}
