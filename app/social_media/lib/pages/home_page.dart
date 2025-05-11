import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:social_media/pages/nav_pages/search_page.dart';
import 'package:social_media/services/videoServices.dart';
import 'package:social_media/services/walletServices.dart';
import 'package:social_media/styling/colors.dart';
import 'package:social_media/styling/sizeConfig.dart';
import 'package:social_media/widgets/videoCard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  final TextEditingController _searchController = TextEditingController();

  bool _isFetching = false;
  List<dynamic> videos = [];
  List<dynamic> following = [];
  num balance = 0;

  void fetchList() async {
    setState(() {
      _isFetching = true;
    });
    final list = await Videoservices.getFollowingVideos(context);
    final price = await Walletservices.getBalance(context);

    setState(() {
      videos = list[0]["list"];
      following = list[0]["following"];
      balance = price[0]["balance"];
      _isFetching = false;
    });
  }

  void fetchBalance() async {
    final price_list = await Walletservices.getBalance(context);
    setState(() {
      balance = price_list[0]["balance"];
    });
  }

  String thumbnailURL(String url) {
    return url
        .replaceFirst('/upload/', '/upload/so_1/') // adds 'start offset 1 sec'
        .replaceAll('.mp4', '.jpg');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchList();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          //* Header Card
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 15.80056*SizeConfig.heightMultiplier,
            backgroundColor: ColorsApp.backgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.symmetric(vertical: 2.10674*SizeConfig.heightMultiplier, horizontal: 2.23214*SizeConfig.widthMultiplier),
                child: Container(
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.6785*SizeConfig.widthMultiplier),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Follow you favorite person to\nwatch their Chapter.",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 2.580759*SizeConfig.heightMultiplier,
                              fontWeight: FontWeight.w700),
                        ),
                        Icon(
                          Icons.group,
                          color: Colors.white,
                          size: 5.89887*SizeConfig.heightMultiplier,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )

          //* Search Bar
          ,
          SliverAppBar(
            automaticallyImplyLeading: false,
            floating: true,
            snap: true,
            backgroundColor: ColorsApp.backgroundColor,
            toolbarHeight: 9.48034*SizeConfig.heightMultiplier,
            title: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => SearchPage(
                            following: following,
                          )),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.2640453*SizeConfig.heightMultiplier),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          spreadRadius: 2,
                          color: Colors.grey.shade100)
                    ]),
                height: 6.32024*SizeConfig.heightMultiplier,
                child: TextField(
                  enabled: false,
                  style: TextStyle(color: Colors.grey.shade200, fontSize: 2.31741*SizeConfig.heightMultiplier),
                  controller: _searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(2.106*SizeConfig.heightMultiplier),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 3.160113*SizeConfig.heightMultiplier,
                      color: Colors.grey.shade200,
                    ),
                    label: Text(
                      "Search for creators and videos",
                      style:
                          TextStyle(color: Colors.grey.shade200, fontSize: 2.31741*SizeConfig.heightMultiplier),
                    ),
                    filled: true,
                    fillColor: ColorsApp.backgroundColor,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1.2640453*SizeConfig.heightMultiplier),
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(1.2640453*SizeConfig.heightMultiplier),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(1.2640453*SizeConfig.heightMultiplier),
                        borderSide: BorderSide(color: Colors.white)),
                  ),
                ),
              ),
            ),
          )
        ];
      },
      body: Padding(
        padding: EdgeInsets.only(top: 3.1601*SizeConfig.heightMultiplier, left: 2.232*SizeConfig.widthMultiplier, right: 2.232*SizeConfig.widthMultiplier, bottom: 2.106*SizeConfig.heightMultiplier),
        child: Skeletonizer(
          enabled: _isFetching,
          child: MasonryGridView.count(
            clipBehavior: Clip.none,
            shrinkWrap: true,
            itemCount: _isFetching ? 6 : videos.length,
            crossAxisCount: 2,
            mainAxisSpacing: 18,
            crossAxisSpacing: 18,
            itemBuilder: (context, index) {
              // Loading state → skeleton placeholder
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

              // Data state → real cards
              final vid = videos[index];
              return InkWell(
                // onTap: () => Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => Videoplayer(isHome: false),
                //   ),
                // ),
                child: videoCard(
                    context,
                    vid["title"],
                    vid["uploadedAt"],
                    vid["videoCreator"],
                    balance,
                    thumbnailURL(vid["videoURL"]),
                    fetchBalance),
              );
            },
          ),
        ),
      ),
    );
  }
}
