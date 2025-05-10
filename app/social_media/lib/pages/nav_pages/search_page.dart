import 'package:flutter/material.dart';
import 'package:social_media/helper/shared_pref.dart';
import 'package:social_media/services/accountService.dart';
import 'package:social_media/services/videoServices.dart';
import 'package:social_media/styling/colors.dart';
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
                  'Search Users',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 34),
                ),
              ),
              SliverAppBar(
                automaticallyImplyLeading: false,
                floating: true,
                snap: true,
                backgroundColor: ColorsApp.backgroundColor,
                toolbarHeight: 100,
                title: InkWell(
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (_) => SearchPage()),
                    // );
                  },
                  child: Container(
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
                          TextStyle(color: Colors.grey.shade200, fontSize: 22),
                      controller: _searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.grey.shade200,
                        ),
                        label: Text(
                          "Search for creators and videos",
                          style: TextStyle(
                              color: Colors.grey.shade200, fontSize: 22),
                        ),
                        filled: true,
                        fillColor: ColorsApp.backgroundColor,
                        floatingLabelBehavior: FloatingLabelBehavior.never,
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
                ),
              )
            ];
          },
          body: _isSearched
              ? _accounts.length == 0
                  ? Center(
                      child: Text(
                        "No Accounts Found",
                        style: TextStyle(color: Colors.white, fontSize: 36),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _accounts.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            minTileHeight: 85,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 189, 167, 247),
                                    width: 2)),
                            tileColor: Color.fromARGB(255, 32, 32, 32),
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.purple.shade600,
                              child: Center(
                                child: Text(
                                  _accounts[index]["name"]
                                      .toString()[0]
                                      .toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ),
                              ),
                            ),
                            title: Text(
                              _accounts[index]["name"].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24),
                            ),
                            subtitle: Text(
                              "@${_accounts[index]["email"].toString()}",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            trailing: TextButton(
                                style: ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        Colors.purple.shade600),
                                    shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
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
                                        fontSize: 20),
                                  ),
                                )),
                          ),
                        );
                      })
              : Center(
                  child: Text(
                    "Search To Find Accounts",
                    style: TextStyle(color: Colors.white, fontSize: 36),
                  ),
                )),
    ));
  }
}
