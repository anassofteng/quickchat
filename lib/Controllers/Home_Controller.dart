import 'package:demo_application/consts/consts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  late SharedPreferences prefs;
  static HomeController instance = Get.find();
  String username = '';
  String userImage = '';
  getUserDetails() async {
    await firebaseFirestore
        .collection(collectionUser)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) async {
      username = value.docs[0]['name'];
      userImage = value.docs[0]['img_url'];
      prefs = await SharedPreferences.getInstance();
      prefs.setStringList('user_details', [
        value.docs[0]['name'],
        // value.docs[0]['img_url']
      ]);
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getUserDetails();
    super.onInit();
  }
}
