import 'package:flutter/material.dart';
import 'package:social_media/styling/colors.dart';

Widget normalField(TextEditingController controller,IconData icon,String title) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(blurRadius: 1, spreadRadius: 1, color: Colors.grey.shade100)
        ]),
    height: 60,
    child: TextField(
      style: TextStyle(color: Colors.grey.shade200, fontSize: 22),
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          size: 26,
          color: Colors.grey.shade200,
        ),
        label: Text(
          title,
          style: TextStyle(color: Colors.grey.shade200, fontSize: 22),
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
  );
}


