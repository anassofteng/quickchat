import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_application/consts/consts.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';

class ProfileController extends GetxController {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var aboutController = TextEditingController();

  var imgpath = ''.obs;
  var imglink = '';

  updateProfile(
    context,
  ) async {
    var store =
        firebaseFirestore.collection(collectionUser).doc(currentUser!.uid);
    await store.set({
      'name': nameController.text,
      'about': aboutController.text,
      'img_url': imglink,
    }, SetOptions(merge: true));
    VxToast.show(context, msg: "Profile updated successfully");
  }

  pickImage(context, source) async {
    await Permission.photos.request();
    await Permission.camera.request();
    var status = await Permission.photos.status;
    if (!status.isGranted) {
      try {
        final img =
            await ImagePicker().pickImage(source: source, imageQuality: 80);
        imgpath.value = img!.path;
        VxToast.show(context, msg: "Successfuly selected");
      } on PlatformException catch (e) {
        VxToast.show(context, msg: e.toString());
      }
    } else {
      VxToast.show(context, msg: "Permission Denied");
    }
  }

  uploadImage() async {
    var name = basename(imgpath.value);

    var destination = 'images/${currentUser!.uid}/$name';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(imgpath.value));

    var d = await ref.getDownloadURL();
    imglink = d;
  }
}
