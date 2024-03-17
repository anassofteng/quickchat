import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_application/Services/Services.dart';
import 'package:demo_application/Views/Chat_Screen/Chat_Screen.dart';
import 'package:demo_application/Views/homescreen/components/message_bubble.dart';
import 'package:demo_application/consts/colors.dart';
import 'package:demo_application/consts/consts.dart';
import 'package:demo_application/consts/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

Widget chatsComponent() {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: StreamBuilder(
        stream: StoreServices.getMessage(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(bgColor),
              ),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: "Start a conversation..."
                  .text
                  .fontFamily(semibold)
                  .color(txtColor)
                  .make(),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                var doc = snapshot.data!.docs[index];
                return messagebubble(doc);
              }).toList(),
            );
          }
        },
      ));
}
