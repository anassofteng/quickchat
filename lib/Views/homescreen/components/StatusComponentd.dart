import 'package:demo_application/consts/colors.dart';
import 'package:demo_application/consts/images.dart';
import 'package:demo_application/consts/strings.dart';
import 'package:demo_application/utils.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget statusComponent() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundColor: btnColor,
            child: Image.asset(
              ic_user,
              color: Colors.white,
            ),
          ),
          title: RichText(
            text: const TextSpan(children: [
              TextSpan(
                text: "My status\n",
                style: TextStyle(
                  fontFamily: semibold,
                  fontSize: 14,
                  color: txtColor,
                ),
              ),
              TextSpan(
                text: "Tap to add statu Updates",
                style: TextStyle(
                  fontFamily: semibold,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ]),
          ),
        ),
        20.heightBox,
        recentupdates.text.fontFamily(semibold).color(txtColor).make(),
        20.heightBox,
        Expanded(
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 30,
              itemBuilder: (BuildContext context, int index) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundColor: Vx.randomColor,
                        child: Image.asset(ic_user),
                      ),
                      title: "Username"
                          .text
                          .fontFamily(semibold)
                          .color(Vx.white)
                          .make(),
                      subtitle: "Today, 8:47 PM".text.gray400.make(),
                    ),
                  ),
                );
              }),
        )
      ],
    ),
  );
}
