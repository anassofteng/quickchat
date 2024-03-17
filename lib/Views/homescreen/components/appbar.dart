import 'package:demo_application/consts/colors.dart';
import 'package:demo_application/consts/consts.dart';
import 'package:demo_application/consts/images.dart';
import 'package:demo_application/consts/strings.dart';
import 'package:flutter/material.dart';

import '../../../utils.dart';

Widget appbar(GlobalKey<ScaffoldState> key) {
  return Container(
    padding: const EdgeInsets.only(right: 12),
    color: Colors.white,
    height: 80,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            key.currentState!.openDrawer();
          },
          child: Container(
            decoration: const BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(100),
                bottomRight: Radius.circular(100),
              ),
            ),
            height: 80,
            width: 90,
            child: const Icon(
              settingsIcon,
              color: Colors.white,
            ),
          ),
        ),
        RichText(
            text: const TextSpan(
          children: [
            TextSpan(
              text: "  $appname\n",
              style: TextStyle(
                  fontFamily: bold, fontSize: 22, color: Colors.black),
            ),
            TextSpan(
              text: "               $connectingLives",
              style: TextStyle(
                  fontFamily: "lato",
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ],
        )),
        // CircleAvatar(
        //   backgroundColor: bgColor,
        //   radius: 25,
        //   child: Image.network(
        //     HomeController.instance.userImage,
        //     color: Colors.white,
        //   ).box.roundedFull.clip(Clip.antiAlias).make(),
        // ),
      ],
    ),
  );
}
