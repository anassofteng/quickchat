import 'package:demo_application/Controllers/Home_Controller.dart';
import 'package:demo_application/consts/consts.dart';

class ChatController extends GetxController {
  dynamic chatId;
  var chats = firebaseFirestore.collection(collectionChats);
  var userId = currentUser!.uid;
  var friendId = Get.arguments[1];
  var username =
      HomeController.instance.prefs.getStringList('user_details')![0];
  var friendname = Get.arguments[0];
  var messageController = TextEditingController();
  var isloading = false.obs;

  getChatId() async {
    isloading(true);
    await chats
        .where('users', isEqualTo: {friendId: Null, userId: Null})
        .limit(1)
        .get()
        .then((QuerySnapshot snapshot) async {
          if (snapshot.docs.isEmpty) {
            chatId = snapshot.docs.single.id;
          } else {
            chats.add({
              'users': {userId: null, friendId: null},
              'friend_name': friendname,
              'user_name': username,
              'fromId': '',
              "created_on": Null,
              'last_msg': ''
            }).then((value) {
              chatId = value.id;
            });
          }
        });
    isloading(false);
  }

  sendmessage(String msg) {
    if (msg.trim().isNotEmptyAndNotNull) {
      chats.doc(chatId).update({
        'created_on': FieldValue.serverTimestamp(),
        'last_msg': msg,
        'toId': friendId,
        'fromId': userId,
      });
      chats.doc(chatId).collection(collectioMessages).doc().set({
        'created_on': FieldValue.serverTimestamp(),
        'msg': msg,
        'uid': userId,
      }).then((value) {
        messageController.clear();
      });
    } else {}
  }

  @override
  onInit() {
    getChatId();
    super.onInit();
  }
}
