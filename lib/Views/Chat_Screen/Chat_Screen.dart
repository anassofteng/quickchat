import 'package:demo_application/Services/Services.dart';
import 'package:demo_application/Views/Chat_Screen/chat_Bubble.dart';
import 'package:demo_application/consts/consts.dart';

class ChatSreen extends StatelessWidget {
  const ChatSreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatController());
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0.0,
        actions: const [
          Icon(
            Icons.more_vert_rounded,
            color: Colors.white,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                      child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${controller.friendname}\n",
                          style: const TextStyle(
                              fontFamily: semibold,
                              fontSize: 16,
                              color: Colors.black),
                        ),
                        const TextSpan(
                          text: "Last Seen",
                          style: TextStyle(
                              fontFamily: semibold,
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  )),
                  const CircleAvatar(
                    backgroundColor: btnColor,
                    child: Icon(
                      Icons.video_call_rounded,
                      color: Colors.white,
                    ),
                  ),
                  10.widthBox,
                  const CircleAvatar(
                    backgroundColor: btnColor,
                    child: Icon(
                      Icons.call,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            30.heightBox,
            Obx(
              () => Expanded(
                child: controller.isloading.value
                    ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(bgColor),
                        ),
                      )
                    : StreamBuilder(
                        stream: StoreServices.getChats(controller.chatId),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Container();
                          } else {
                            return ListView(
                              children: snapshot.data!.docs
                                  .mapIndexed((currentValue, index) {
                                var doc = snapshot.data!.docs[index];
                                return chatbubble(index, doc);
                              }).toList(),
                            );
                          }
                        },
                      ),
              ),
            ),
            10.heightBox,
            SizedBox(
              height: 56,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextFormField(
                      controller: controller.messageController,
                      maxLines: 1,
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: semibold,
                          fontSize: 14),
                      cursorColor: Colors.white,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.emoji_emotions_rounded,
                          color: Colors.white,
                        ),
                        suffixIcon: Icon(
                          Icons.attachment,
                          color: Colors.grey,
                        ),
                        border: InputBorder.none,
                        hintText: "Type messsage here....",
                        hintStyle: TextStyle(
                          fontFamily: semibold,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )),
                  const WidthBox(20),
                  GestureDetector(
                    onTap: () {
                      controller.sendmessage(controller.messageController.text);
                    },
                    child: const CircleAvatar(
                      backgroundColor: btnColor,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
