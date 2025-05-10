import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:social_media/pages/nav_pages/search_page.dart';
import 'package:social_media/services/videoServices.dart';
import 'package:social_media/services/walletServices.dart';
import 'package:social_media/styling/colors.dart';
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
            expandedHeight: 150,
            backgroundColor: ColorsApp.backgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Container(
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
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Follow you favorite person to\nwatch their Chapter.",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.5,
                              fontWeight: FontWeight.w700),
                        ),
                        Icon(
                          Icons.group,
                          color: Colors.white,
                          size: 56,
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
            toolbarHeight: 90,
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
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 5,
                          spreadRadius: 2,
                          color: Colors.grey.shade100)
                    ]),
                height: 60,
                child: TextField(
                  enabled: false,
                  style: TextStyle(color: Colors.grey.shade200, fontSize: 22),
                  controller: _searchController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.grey.shade200,
                    ),
                    label: Text(
                      "Search for creators and videos",
                      style:
                          TextStyle(color: Colors.grey.shade200, fontSize: 22),
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
      body: Padding(
        padding: EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 20),
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
