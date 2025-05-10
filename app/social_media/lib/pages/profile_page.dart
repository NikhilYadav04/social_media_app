import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:social_media/pages/auth/login_page.dart';
import 'package:social_media/pages/nav_pages/wallet_page.dart';
import 'package:social_media/services/accountService.dart';
import 'package:social_media/services/authServices.dart';
import 'package:social_media/services/videoServices.dart';
import 'package:social_media/styling/colors.dart';
import 'package:social_media/widgets/logger_glob.dart';
import 'package:social_media/widgets/videoCard.dart';
import 'package:social_media/widgets/videoCardHome.dart';
import 'package:social_media/widgets/videoPlayer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  List<dynamic> profileDetails = [
    {
      "account": {
        "name": "Dummy",
        "email": "d@gmail.com",
        "follower_count": 0,
        "following_count": 4,
      }
    }
  ];
  List<dynamic> purchased_videos = [];
  List<dynamic> user_videos = [];
  bool _isFetching = false;

  String thumbnailURL(String url) {
    return url
        .replaceFirst('/upload/', '/upload/so_1/') // adds 'start offset 1 sec'
        .replaceAll('.mp4', '.jpg');
  }

  void fetchVideos() async {
    setState(() {
      _isFetching = true;
    });

    profileDetails = await Accountservice.getAccountDetails(context);
    final videos = await Videoservices.getPUVideos(context);
    setState(() {
      profileDetails;
      purchased_videos = videos[0]["purchased_videos"];
      user_videos = videos[0]["user_videos"];
      _isFetching = false;
    });
    printLog(user_videos[0]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchVideos();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 220,
              backgroundColor: ColorsApp.backgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Skeletonizer(
                    enabled: _isFetching,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        height: 220,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                        child: Column(
                          children: [
                            ListTile(
                                // contentPadding: EdgeInsets.symmetric(
                                //     horizontal: 15, vertical: 5),
                                minTileHeight: 85,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: BorderSide(
                                        color:
                                            Color.fromARGB(255, 189, 167, 247),
                                        width: 2)),
                                tileColor: Color.fromARGB(255, 32, 32, 32),
                                leading: CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.purple.shade600,
                                  child: Center(
                                    child: Text(
                                      profileDetails[0]["account"]["name"][0]
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  profileDetails[0]["account"]["name"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 28),
                                ),
                                subtitle: Text(
                                  profileDetails[0]["account"]["email"],
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 226, 221, 221),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                                trailing: SizedBox(
                                  width: 115,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) => WalletPage()),
                                            );
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                      Colors.purple.shade600),
                                              fixedSize: WidgetStatePropertyAll(
                                                  Size(55, 50)),
                                              shape: WidgetStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)))),
                                          icon: Icon(
                                            Icons
                                                .account_balance_wallet_outlined,
                                            size: 28,
                                            color: Colors.white,
                                          )),
                                      IconButton(
                                          onPressed: () async {
                                            await logoutUser();
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LoginPage()));
                                          },
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                      Colors.purple.shade600),
                                              fixedSize: WidgetStatePropertyAll(
                                                  Size(50, 50)),
                                              shape: WidgetStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)))),
                                          icon: Icon(
                                            Icons.power_settings_new_sharp,
                                            size: 28,
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 14,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Colors.purple.shade600),
                                          shape: WidgetStatePropertyAll(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12))),
                                          fixedSize: WidgetStatePropertyAll(
                                              Size(150, 50))),
                                      onPressed: () {},
                                      child: Text(
                                        "Followers  ${profileDetails[0]["account"]["follower_count"]}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  TextButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStatePropertyAll(
                                                  Colors.purple.shade600),
                                          shape: WidgetStatePropertyAll(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12))),
                                          fixedSize: WidgetStatePropertyAll(
                                              Size(150, 50))),
                                      onPressed: () {},
                                      child: Text(
                                        "Following  ${profileDetails[0]["account"]["following_count"]}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      )),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              ),
            )
          ];
        },
        body: Column(
          children: [
            TabBar(
                labelColor: Colors.purple.shade700,
                unselectedLabelColor: Colors.white,
                indicatorColor: Colors.purple.shade700,
                controller: _tabController,
                labelStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                tabs: [
                  Tab(
                    text: "Purchased",
                  ),
                  Tab(
                    text: "Uploaded",
                  ),
                ]),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
                  child: MasonryGridView.count(
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    itemCount: _isFetching ? 4 : purchased_videos.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                    itemBuilder: (context, index) {
                      //* Show Skeletonizer
                      if (_isFetching) {
                        return Skeletonizer(
                          enabled: true,
                          child: videoCard(
                            context,
                            '',
                            '',
                            '',
                            0,
                            "",
                            () {},
                          ),
                        );
                      }

                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Videoplayer(
                                          title: purchased_videos[index]
                                              ["title"],
                                          quality: purchased_videos[index]
                                              ["videoQuality"],
                                          videoCreator: purchased_videos[index]
                                              ["videoCreator"],
                                          videoURL: purchased_videos[index]
                                              ["videoURL"],
                                          isHome: false,
                                        )));
                          },
                          child: videoCardHome(
                            purchased_videos[index]["title"],
                            purchased_videos[index]["uploadedAt"],
                            purchased_videos[index]["videoCreator"],
                            purchased_videos[index]["videoURL"],
                          ));
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 20),
                  child: MasonryGridView.count(
                    clipBehavior: Clip.none,
                    shrinkWrap: true,
                    itemCount: _isFetching ? 4 : user_videos.length,
                    crossAxisCount: 2,
                    mainAxisSpacing: 18,
                    crossAxisSpacing: 18,
                    itemBuilder: (context, index) {
                      //* Show Skeletonizer
                      if (_isFetching) {
                        return Skeletonizer(
                          enabled: true,
                          child: videoCard(
                            context,
                            '',
                            '',
                            '',
                            0,
                            "",
                            () {},
                          ),
                        );
                      }

                      return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => Videoplayer(
                                          title: user_videos[index]["title"],
                                          quality: "1080p",
                                          videoCreator: user_videos[index]
                                              ["videoCreator"],
                                          videoURL: user_videos[index]
                                              ["videoURL"],
                                          isHome: true,
                                        )));
                          },
                          child: videoCardHome(
                            user_videos[index]["title"],
                            user_videos[index]["uploadedAt"],
                            user_videos[index]["videoCreator"],
                            user_videos[index]["videoURL"],
                          ));
                    },
                  ),
                ),
              ]),
            ),
          ],
        ));
  }
}
