import 'package:demo_application/consts/consts.dart';
import 'package:image_picker/image_picker.dart';

Widget pickerDialog(context, controller) {
  var listTitle = [camera, gallery, cancel];
  var icons = [
    Icons.camera_alt_rounded,
    Icons.photo_size_select_actual_rounded,
    Icons.cancel
  ];
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    child: Container(
      padding: const EdgeInsets.all(12),
      color: bgColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          source.text.fontFamily(semibold).white.make(),
          Divider(),
          10.heightBox,
          ListView(
            shrinkWrap: true,
            children: List.generate(
                3,
                (index) => ListTile(
                      onTap: () {
                        switch (index) {
                          case 0:
                            Get.back();
                            controller.pickImage(context, ImageSource.camera);
                            break;
                          case 1:
                            Get.back();
                            controller.pickImage(context, ImageSource.gallery);
                            break;
                          case 2:
                            Get.back();
                            break;

                          default:
                        }
                      },
                      leading: Icon(
                        icons[index],
                        color: Colors.white,
                      ),
                      title: listTitle[index].text.white.make(),
                    )),
          ),
        ],
      ),
    ),
  );
}
