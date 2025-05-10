import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:social_media/pages/nav_pages/wallet_history_page.dart';
import 'package:social_media/services/walletServices.dart';
import 'package:social_media/styling/colors.dart';

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
                toolbarHeight: 75,
                centerTitle: true,
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 38,
                    )),
                title: Text(
                  'Wallet',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 34),
                ),
              ),
            ];
          },
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                SizedBox(
                  height: 12,
                ),
                Skeletonizer(
                  enabled: _isFetching,
                  child: Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
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
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
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
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),
                              ),
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                color: Colors.white,
                                size: 28,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            "₹$balance",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 52,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton.icon(
                              label: FittedBox(
                                child: Text(
                                  "Last updated : $updatedAt",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: WidgetStatePropertyAll(
                                      Colors.purple.shade700),
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5))),
                                  fixedSize:
                                      WidgetStatePropertyAll(Size(285, 50))),
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
                                size: 23,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 35,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 14),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 53, 51, 51),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recharge Wallet",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 33,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Enter amount to add to your wallet",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 22,
                              fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 28,
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
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                                color: Colors.grey.shade200, fontSize: 22),
                            controller: _amountController,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.currency_rupee,
                                size: 30,
                                color: Colors.grey.shade200,
                              ),
                              label: Text(
                                "Enter Amount To Recharge",
                                style: TextStyle(
                                    color: Colors.grey.shade200, fontSize: 22),
                              ),
                              filled: true,
                              fillColor: ColorsApp.backgroundColor,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 28,
                        ),
                        Text(
                          "Quick Select : ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 22,
                              fontWeight: FontWeight.w600),
                        ),

                        SizedBox(
                          height: 17,
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
                          height: 160,
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
                                        WidgetStatePropertyAll(Size(400, 60)),
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)))),
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
                                        fontSize: 26,
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
          fixedSize: WidgetStatePropertyAll(Size(90, 50)),
          shape: WidgetStatePropertyAll(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),
      onPressed: () {
        _amountController.text = value.toString();
      },
      child: Center(
        child: FittedBox(
          child: Text(
            "₹$value",
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),
          ),
        ),
      ));
}
