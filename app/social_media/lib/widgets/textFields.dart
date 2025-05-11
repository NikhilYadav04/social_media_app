import 'package:flutter/material.dart';
import 'package:social_media/styling/colors.dart';
import 'package:social_media/styling/sizeConfig.dart';

Widget normalField(TextEditingController controller,IconData icon,String title) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.2640*SizeConfig.heightMultiplier),
        boxShadow: [
          BoxShadow(blurRadius: 1, spreadRadius: 1, color: Colors.grey.shade100)
        ]),
    height: 6.32024*SizeConfig.heightMultiplier,
    child: TextField(
      style: TextStyle(color: Colors.grey.shade200, fontSize: 2.31742*SizeConfig.heightMultiplier),
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          size: 2.73876*SizeConfig.heightMultiplier,
          color: Colors.grey.shade200,
        ),
        label: Text(
          title,
          style: TextStyle(color: Colors.grey.shade200, fontSize: 2.31742*SizeConfig.heightMultiplier),
        ),
        filled: true,
        fillColor: ColorsApp.backgroundColor,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1.2640*SizeConfig.heightMultiplier),
            borderSide: BorderSide(color: Colors.black)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(1.2640*SizeConfig.heightMultiplier),
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(1.2640*SizeConfig.heightMultiplier),
            borderSide: BorderSide(color: Colors.white)),
      ),
    ),
  );
}


