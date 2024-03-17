import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_application/Controllers/firebase_const.dart';
import 'package:demo_application/Controllers/profile_controller.dart';
import 'package:demo_application/Services/Services.dart';
import 'package:demo_application/Views/picker_Dialogue/picker_Dialogue.dart';
import 'package:demo_application/consts/colors.dart';
import 'package:demo_application/consts/images.dart';
import 'package:demo_application/consts/strings.dart';
import 'package:demo_application/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () async {
                if (controller.imgpath.isEmpty) {
                  controller.updateProfile(context);
                } else {
                  await controller.uploadImage();
                  controller.updateProfile(context);
                }
              },
              child: "save".text.white.fontFamily(semibold).make()),
        ],
        title: profile.text.fontFamily(bold).make(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        padding: const EdgeInsets.all(12.0),
        // alignment: Alignment.center,
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: StoreServices.getUser(currentUser!.uid),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.docs[0];
                  controller.nameController.text = data['name'];
                  controller.aboutController.text = data['about'];
                  controller.phoneController.text = data['phonenumber'];
                  return Column(
                    children: [
                      Obx(
                        () => CircleAvatar(
                          radius: 100,
                          backgroundColor: Colors.transparent,
                          child: Stack(
                            children: [
                              controller.imgpath.isEmpty &&
                                      data['img_url'] == ''
                                  ? Image.asset(
                                      ic_user,
                                      color: Colors.white,
                                    )
                                  : controller.imgpath.isNotEmpty
                                      ? Image.file(
                                          File(controller.imgpath.value),
                                        )
                                          .box
                                          .roundedFull
                                          .clip(Clip.antiAlias)
                                          .make()
                                      : Image.network(
                                          data['img_url'],
                                        )
                                          .box
                                          .roundedFull
                                          .clip(Clip.antiAlias)
                                          .make(),
                              Positioned(
                                right: 0,
                                bottom: 15,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 12,
                                  child: Icon(
                                    Icons.camera_alt_rounded,
                                    color: Colors.white,
                                  ).onTap(() {
                                    Get.dialog(
                                        pickerDialog(context, controller));
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      20.heightBox,
                      ListTile(
                        leading: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        title: TextFormField(
                          controller: controller.nameController,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            label: "Name".text.white.make(),
                            isDense: true,
                            labelStyle: const TextStyle(
                                fontFamily: semibold, color: Colors.white),
                          ),
                        ),
                        subtitle:
                            namesub.text.fontFamily(semibold).gray600.make(),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.info,
                          color: Colors.white,
                        ),
                        title: TextFormField(
                          controller: controller.aboutController,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: InputBorder.none,
                            suffixIcon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                            label: "About".text.make(),
                            isDense: true,
                            labelStyle: const TextStyle(
                                fontFamily: semibold, color: Colors.white),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.call,
                          color: Colors.white,
                        ),
                        title: TextFormField(
                          controller: controller.phoneController,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          readOnly: true,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            label: "Phone".text.make(),
                            isDense: true,
                            labelStyle: const TextStyle(
                                fontFamily: semibold, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.white),
                    ),
                  );
                }
                ;
              }),
        ),
      ),
    );
  }
}
