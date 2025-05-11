import 'package:flutter/material.dart';
import 'package:social_media/helper/shared_pref.dart';
import 'package:social_media/services/accountService.dart';
import 'package:social_media/services/videoServices.dart';
import 'package:social_media/styling/colors.dart';
import 'package:social_media/styling/sizeConfig.dart';
import 'package:social_media/widgets/toast.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  List<dynamic> following;
  SearchPage({super.key, required this.following});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool _isSearched = false;
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _accounts = [];

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
                toolbarHeight: 7.90030*SizeConfig.heightMultiplier,
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
                  'Search Users',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 3.5814*SizeConfig.heightMultiplier),
                ),
              ),
              SliverAppBar( 
                automaticallyImplyLeading: false,
                floating: true,
                snap: true,
                backgroundColor: ColorsApp.backgroundColor,
                toolbarHeight: 10.5337*SizeConfig.heightMultiplier,
                title: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => SearchPage()),
                    // );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.264*SizeConfig.heightMultiplier),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 2,
                              color: Colors.grey.shade100)
                        ]),
                    height: 6.32024*SizeConfig.heightMultiplier,
                    child: TextField(
                      onChanged: (value) async {
                        //* Search for accounts api call
                        final list =
                            await Accountservice.searchAccounts(context, value);
                        setState(() {
                          _isSearched = true;
                          _accounts = list;
                        });
                      },
                      style:
                          TextStyle(color: Colors.grey.shade200, fontSize: 2.31742*SizeConfig.heightMultiplier),
                      controller: _searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          size:3.160*SizeConfig.heightMultiplier,
                          color: Colors.grey.shade200,
                        ),
                        label: Text(
                          "Search for creators and videos",
                          style: TextStyle(
                              color: Colors.grey.shade200, fontSize: 2.31742*SizeConfig.heightMultiplier),
                        ),
                        filled: true,
                        fillColor: ColorsApp.backgroundColor,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
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
                ),
              )
            ];
          },
          body: _isSearched
              ? _accounts.length == 0
                  ? Center(
                      child: Text(
                        "No Accounts Found",
                        style: TextStyle(color: Colors.white, fontSize: 3.79213*SizeConfig.heightMultiplier),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _accounts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 2.6785*SizeConfig.widthMultiplier, vertical: 0.84269*SizeConfig.heightMultiplier),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 3.3482*SizeConfig.widthMultiplier, vertical: 0.5266*SizeConfig.heightMultiplier),
                            minTileHeight: 8.9536*SizeConfig.heightMultiplier,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1.053*SizeConfig.heightMultiplier),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 189, 167, 247),
                                    width: 2)),
                            tileColor: Color.fromARGB(255, 32, 32, 32),
                            leading: CircleAvatar(
                              radius: 2.6334*SizeConfig.heightMultiplier,
                              backgroundColor: Colors.purple.shade600,
                              child: Center(
                                child: Text(
                                  _accounts[index]["name"]
                                      .toString()[0]
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 2.949448*SizeConfig.heightMultiplier),
                                ),
                              ),
                            ),
                            title: Text(
                              _accounts[index]["name"].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 2.5280*SizeConfig.heightMultiplier),
                            ),
                            subtitle: Text(
                              "@${_accounts[index]["email"].toString()}",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 1.8960*SizeConfig.heightMultiplier),
                            ),
                            trailing: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        Colors.purple.shade600),
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(1.580068*SizeConfig.heightMultiplier),
                                      ),
                                    )),
                                onPressed: () async {
                                  final userName =
                                      await LocalStorageFunctions.getName();

                                  //* Follow or Unfollow
                                  if (userName ==
                                      _accounts[index]["name"].toString()) {
                                        toastErrorSlide(context, "Cannot follow your own account");
                                  } else if (widget.following.contains(
                                      _accounts[index]["name"].toString())) {
                                    await Accountservice.followORunfollow(
                                        context,
                                        userName!,
                                        _accounts[index]["name"].toString(),
                                        "Unfollow");
                                  } else {
                                    await Accountservice.followORunfollow(
                                        context,
                                        userName!,
                                        _accounts[index]["name"].toString(),
                                        "Follow");
                                  }

                                  final list =
                                      await Videoservices.getFollowingVideos(
                                          context);
                                  setState(() {
                                    widget.following = list[0]["following"];
                                  });
                                },
                                child: FittedBox(
                                  child: Text(
                                    widget.following.contains(
                                            _accounts[index]["name"].toString())
                                        ? "Following"
                                        : "Follow",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 2.1067*SizeConfig.heightMultiplier),
                                  ),
                                )),
                          ),
                        );
                      })
              : Center(
                  child: Text(
                    "Search To Find Accounts",
                    style: TextStyle(color: Colors.white, fontSize:3.79214*SizeConfig.heightMultiplier),
                  ),
                )),
    ));
  }
}
