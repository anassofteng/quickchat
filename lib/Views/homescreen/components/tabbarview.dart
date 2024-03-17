import 'package:demo_application/Views/homescreen/components/StatusComponentd.dart';
import 'package:demo_application/Views/homescreen/components/chats_Component.dart';
import 'package:flutter/material.dart';

Widget tabbarView() {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(12),
        ),
      ),
      child: TabBarView(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: chatsComponent(),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: statusComponent(),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
