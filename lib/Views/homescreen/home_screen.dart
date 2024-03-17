import 'package:demo_application/consts/consts.dart';
import 'package:flutter/material.dart';

import '../../Controllers/Home_Controller.dart';
import 'components/appbar.dart';
import 'components/dawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Scaffoldkey = GlobalKey<ScaffoldState>();
    var controller = Get.put(HomeController());
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          key: Scaffoldkey,
          drawer: drawer(),
          floatingActionButton: FloatingActionButton.small(
            backgroundColor: btnColor,
            onPressed: () {
              Get.to(() => const ComposeScreen(),
                  transition: Transition.downToUp);
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          backgroundColor: bgColor,
          body: Column(children: [
            appbar(Scaffoldkey),
            Expanded(
              child: Row(
                children: [
                  tabbar(),
                  tabbarView(),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
