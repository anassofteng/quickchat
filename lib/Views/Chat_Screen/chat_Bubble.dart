import 'package:demo_application/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget chatbubble(index, DocumentSnapshot doc) {
  var t =
      doc['created_on'] == null ? DateTime.now() : doc['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  return Directionality(
    textDirection:
        doc['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor:
                doc['uid'] == currentUser!.uid ? bgColor : btnColor,
            child: Image.asset(
              ic_user,
              color: Colors.white,
            ),
          ),
          20.widthBox,
          Expanded(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: doc['uid'] == currentUser!.uid
                      ? bgColor
                      : Colors.redAccent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Directionality(
                  textDirection: TextDirection.ltr,
                  child: "${doc['msg']}".text.fontFamily(semibold).white.make(),
                ),
              ),
            ),
          ),
          // TextButton.icon(
          //   onPressed: null,
          //   icon: Icon(
          //     Icons.access_time_filled_sharp,
          //     color: Colors.grey,
          //   ),
          //   label: "11:00 AM"
          //       .text
          //       .fontFamily(semibold)
          //       .gray400
          //       .make(),
          // ),
          10.widthBox,
          Directionality(
              textDirection: TextDirection.ltr,
              child: time.text.fontFamily(light).gray400.make()),
        ],
      ),
    ),
  );
}
