import 'package:demo_application/consts/consts.dart';

import '../../Chat_Screen/Chat_Screen.dart';
import 'package:intl/intl.dart' as intl;

Widget messagebubble(DocumentSnapshot doc) {
  var t =
      doc['created_on'] == null ? DateTime.now() : doc['created_on'].toDate();
  var time = intl.DateFormat("h:ma").format(t);
  return Card(
    child: ListTile(
      onTap: () {
        Get.to(() => const ChatSreen(),
            transition: Transition.downToUp,
            arguments: [
              currentUser!.uid == doc['told']
                  ? doc['friend_name']
                  : doc['user_name'],
              currentUser!.uid == doc['toId'] ? doc['fromId'] : doc['toId']
            ]);
      },
      leading: CircleAvatar(
          radius: 25,
          backgroundColor: bgColor,
          child: Image.asset(
            ic_user,
            color: Colors.white,
          )),
      title: currentUser!.uid == doc['told']
          ? "${['friend_name']}".text.fontFamily(semibold).size(14).make()
          : "${doc['user_name']}".text.size(16).semiBold.make(),
      subtitle: "${doc['last_msg']}".text.maxLines(1).size(14).make(),
      trailing: Directionality(
          textDirection: TextDirection.rtl,
          child: TextButton.icon(
              onPressed: null,
              icon: const Icon(
                Icons.access_time_filled_rounded,
                size: 16,
                color: Vx.gray400,
              ),
              label: time.text.color(Vx.gray400).size(12).make())),
    ),
  );
}
