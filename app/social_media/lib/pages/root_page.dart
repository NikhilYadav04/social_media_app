import 'package:flutter/material.dart';
import 'package:social_media/pages/home_page.dart';
import 'package:social_media/pages/profile_page.dart';
import 'package:social_media/pages/upload_page.dart';
import 'package:social_media/styling/colors.dart';
import 'package:social_media/styling/sizeConfig.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _currentIndex = 0;
  List<Widget> pages = [HomePage(), UploadPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorsApp.backgroundColor,

      //* Body
      body: pages[_currentIndex],

      //* Bottom Bar
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (value) {
            setState(() {
              _currentIndex = value;
            });
          },
          backgroundColor: ColorsApp.barColor,
          unselectedItemColor: Colors.grey.shade200,
          selectedItemColor: Colors.white,
          iconSize: 2.7387650*SizeConfig.heightMultiplier,
          selectedFontSize: 2.10674*SizeConfig.heightMultiplier,
          unselectedFontSize: 2.10674*SizeConfig.heightMultiplier,
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.upload,
                ),
                label: 'Upload'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_sharp), label: 'Profile'),
          ]),
    ));
  }
}
