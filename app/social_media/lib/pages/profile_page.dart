import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:social_media/pages/auth/login_page.dart';
import 'package:social_media/pages/nav_pages/wallet_page.dart';
import 'package:social_media/services/accountService.dart';
import 'package:social_media/services/authServices.dart';
import 'package:social_media/services/videoServices.dart';
import 'package:social_media/styling/colors.dart';
import 'package:social_media/styling/sizeConfig.dart';
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
              expandedHeight: 23.17416*SizeConfig.heightMultiplier,
              backgroundColor: ColorsApp.backgroundColor,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.1067*SizeConfig.heightMultiplier, horizontal: 2.2321*SizeConfig.widthMultiplier),
                  child: Skeletonizer(
                    enabled: _isFetching,
                    child: Container(
                        padding: EdgeInsets.symmetric(vertical: 0.4213*SizeConfig.heightMultiplier),
                        height: 23.1742*SizeConfig.heightMultiplier,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.053*SizeConfig.heightMultiplier),
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
                                minTileHeight: 8.953*SizeConfig.heightMultiplier,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(1.053*SizeConfig.heightMultiplier),
                                    side: BorderSide(
                                        color:
                                            Color.fromARGB(255, 189, 167, 247),
                                        width: 2)),
                                tileColor: Color.fromARGB(255, 32, 32, 32),
                                leading: CircleAvatar(
                                  radius: 2.9494*SizeConfig.heightMultiplier,
                                  backgroundColor: Colors.purple.shade600,
                                  child: Center(
                                    child: Text(
                                      profileDetails[0]["account"]["name"][0]
                                          .toString()
                                          .toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 3.16011*SizeConfig.heightMultiplier),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  profileDetails[0]["account"]["name"],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 2.94944*SizeConfig.heightMultiplier),
                                ),
                                subtitle: Text(
                                  profileDetails[0]["account"]["email"],
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 226, 221, 221),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 2.1067*SizeConfig.heightMultiplier),
                                ),
                                trailing: SizedBox(
                                  width: 25.6696*SizeConfig.widthMultiplier,
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
                                                  Size(12.2767*SizeConfig.widthMultiplier, 5.26687*SizeConfig.heightMultiplier)),
                                              shape: WidgetStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0.84269*SizeConfig.heightMultiplier)))),
                                          icon: Icon(
                                            Icons
                                                .account_balance_wallet_outlined,
                                            size: 2.949439*SizeConfig.heightMultiplier,
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
                                                  Size(11.1607*SizeConfig.widthMultiplier, 5.26687*SizeConfig.heightMultiplier)),
                                              shape: WidgetStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                               0.84269*SizeConfig.heightMultiplier)))),
                                          icon: Icon(
                                            Icons.power_settings_new_sharp,
                                            size: 2.94943*SizeConfig.heightMultiplier,
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                )),
                            SizedBox(
                              height: 1.47471*SizeConfig.heightMultiplier,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.67857*SizeConfig.widthMultiplier),
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
                                                          1.2640*SizeConfig.heightMultiplier))),
                                          fixedSize: WidgetStatePropertyAll(
                                              Size(33.482*SizeConfig.widthMultiplier, 5.26687*SizeConfig.heightMultiplier))),
                                      onPressed: () {},
                                      child: Text(
                                        "Followers  ${profileDetails[0]["account"]["follower_count"]}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 2.1067*SizeConfig.heightMultiplier,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  SizedBox(
                                    width: 3.3482*SizeConfig.widthMultiplier,
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
                                                          1.2640453*SizeConfig.heightMultiplier))),
                                          fixedSize: WidgetStatePropertyAll(
                                              Size(33.48214*SizeConfig.widthMultiplier, 5.2668*SizeConfig.heightMultiplier))),
                                      onPressed: () {},
                                      child: Text(
                                        "Following  ${profileDetails[0]["account"]["following_count"]}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 2.1067*SizeConfig.heightMultiplier,
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
                    fontSize: 2.1067*SizeConfig.heightMultiplier,
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
              height: 1.580*SizeConfig.heightMultiplier,
            ),
            Expanded(
              child: TabBarView(controller: _tabController, children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 1.067*SizeConfig.heightMultiplier, left: 2.2321*SizeConfig.widthMultiplier, right: 2.2321*SizeConfig.widthMultiplier, bottom: 1.067*SizeConfig.heightMultiplier),
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
                            thumbnailURL(purchased_videos[index]["videoURL"]),
                          ));
                    },
                  ),
                ),
                Padding(
                  padding:
                       EdgeInsets.only(top: 1.067*SizeConfig.heightMultiplier, left: 2.2321*SizeConfig.widthMultiplier, right: 2.2321*SizeConfig.widthMultiplier, bottom: 1.067*SizeConfig.heightMultiplier),
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
                            thumbnailURL(user_videos[index]["videoURL"]),
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
