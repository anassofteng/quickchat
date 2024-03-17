import 'package:demo_application/Services/Services.dart';
import 'package:demo_application/Views/Chat_Screen/Chat_Screen.dart';
import 'package:demo_application/consts/consts.dart';

class ComposeScreen extends StatelessWidget {
  const ComposeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: "New Message".text.fontFamily(semibold).make(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            color: Colors.white),
        child: StreamBuilder(
          stream: StoreServices.getAllUsers(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(bgColor),
                ),
              );
            } else {
              return GridView(
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                children: snapshot.data!.docs.mapIndexed((currentValue, index) {
                  var doc = snapshot.data!.docs[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: bgColor.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // CircleAvatar(
                                //   radius: 35,
                                //   backgroundImage:
                                //       NetworkImage("${doc['img_url']}"),
                                // ),
                                // 20.heightBox,
                                Expanded(
                                  child: SizedBox(
                                    height: 50,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: "${doc['name']}"
                                          .text
                                          .fontFamily(semibold)
                                          .color(txtColor)
                                          // .maxLines(1)
                                          // .overflow(TextOverflow.ellipsis)
                                          .make(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            10.heightBox,
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                      primary: bgColor,
                                      padding: const EdgeInsets.all(12)),
                                  onPressed: () {
                                    Get.to(
                                      () => const ChatSreen(),
                                      transition: Transition.downToUp,
                                      arguments: [
                                        doc['name'],
                                        doc['id'],
                                      ],
                                    );
                                  },
                                  icon: Icon(Icons.message),
                                  label: "Message".text.make()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
