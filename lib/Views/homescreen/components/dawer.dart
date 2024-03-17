import 'package:demo_application/Controllers/firebase_const.dart';
import 'package:demo_application/Views/Profile%20Screen/Profile_Screen.dart';
import 'package:demo_application/consts/colors.dart';
import 'package:demo_application/consts/consts.dart';
import 'package:demo_application/consts/images.dart';
import 'package:demo_application/consts/strings.dart';
import 'package:demo_application/main.dart';
import 'package:demo_application/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

Widget drawer() {
  return Drawer(
    backgroundColor: bgColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(right: Radius.circular(25)),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(
              Icons.arrow_back,
              color: Colors.deepPurple,
            ),
            onTap: () {
              Get.back();
            },
            title: settings.text.fontFamily(semibold).white.make(),
          ),
          20.heightBox,
          CircleAvatar(
            radius: 45,
            backgroundColor: btnColor,
            child: Image.network(
              HomeController.instance.userImage,
              color: Colors.white,
              fit: BoxFit.cover,
            ).box.roundedFull.clip(Clip.antiAlias).make(),
          ),
          10.heightBox,
          "${HomeController.instance.username}"
              .text
              .white
              .fontFamily(semibold)
              .size(16)
              .make(),
          20.heightBox,
          const Divider(
            color: btnColor,
            height: 1,
          ),
          ListView(
            shrinkWrap: true,
            children: List.generate(
              drawerIconsList.length,
              (index) => ListTile(
                onTap: () async {
                  switch (index) {
                    case 0:
                      Get.to(() => const ProfileScreen(),
                          transition: Transition.downToUp);
                      break;
                    case 6:
                      await auth.signOut();
                      Get.offAll(() => const ChatApp());
                      break;
                    default:
                      Get.back();
                  }
                },
                leading: Icon(
                  drawerIconsList[index],
                  color: Colors.white,
                ),
                title: drawerListTitles[index]
                    .text
                    .fontFamily(semibold)
                    .white
                    .make(),
              ),
            ),
          ),
          10.heightBox,
          const Divider(
            color: btnColor,
            height: 1,
          ),
          10.heightBox,
        ],
      ),
    ),
  );
}
