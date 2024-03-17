import 'package:demo_application/Controllers/Controller.dart';
import 'package:demo_application/consts/colors.dart';
import 'package:demo_application/consts/strings.dart';
import 'package:demo_application/utils.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: letsconnect.text.color(txtColor).fontFamily(bold).make(),
        ),
        body: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Form(
                  key: controller.formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 6) {
                            return "Please enter your username";
                          }
                          return null;
                        },
                        controller: controller.usernameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: ligtgrayColor)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: ligtgrayColor),
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            color: btnColor,
                          ),
                          alignLabelWithHint: true,
                          labelText: "User Name",
                          hintText: " Anas Arshad",
                          labelStyle: const TextStyle(
                            color: txtColor,
                            fontFamily: semibold,
                          ),
                        ),
                      ),
                      10.heightBox,
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty || value.length < 9) {
                            return "Please enter your phone number";
                          }
                          return null;
                        },
                        controller: controller.phonenumberController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: ligtgrayColor)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: ligtgrayColor),
                          ),
                          prefixIcon: const Icon(
                            Icons.phone_android_rounded,
                            color: btnColor,
                          ),
                          alignLabelWithHint: true,
                          labelText: "Phone Number",
                          prefixText: "+9",
                          hintText: " 1234567890",
                          labelStyle: const TextStyle(
                            color: txtColor,
                            fontFamily: semibold,
                          ),
                        ),
                      ),
                    ],
                  )),
              10.heightBox,
              otp.text.fontFamily(semibold).gray400.make(),
              Obx(
                () => Visibility(
                  visible: controller.isOtpsent.value,
                  child: SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          6,
                          (index) => SizedBox(
                                width: 56,
                                child: TextField(
                                  controller: controller.otpcontroller[index],
                                  cursorColor: btnColor,
                                  onChanged: (value) {
                                    if (value.length == 1 && index <= 5) {
                                      FocusScope.of(context).nextFocus();
                                    } else if (value.isEmpty && index > 0) {
                                      FocusScope.of(context).previousFocus();
                                    }
                                  },
                                  style: const TextStyle(
                                      fontFamily: bold, color: btnColor),
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                            color: bgColor,
                                          )),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          borderSide: const BorderSide(
                                            color: bgColor,
                                          )),
                                      hintText: "*"),
                                ),
                              )),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: context.screenWidth - 80,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: btnColor,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.all(16),
                    ),
                    onPressed: () async {
                      if (controller.formkey.currentState!.validate()) {
                        if (controller.isOtpsent.value == false) {
                          controller.isOtpsent.value = true;
                          await controller.sendotp();
                        } else {
                          await controller.verifyOtp(context);
                        }
                      }

                      // Get.to(() => const HomeScreen(),
                      //     transition: Transition.downToUp);

                      print(controller.phonenumberController.text);
                    },
                    child: continuetext.text.fontFamily(semibold).white.make(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
