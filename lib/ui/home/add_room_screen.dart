import 'package:estonedge/base/constants/app_images.dart';
import 'package:flutter/material.dart';

class AddRoomScreen extends StatefulWidget {
  const AddRoomScreen({super.key});

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 40),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          style: BorderStyle.solid,
          color: const Color.fromRGBO(192, 192, 192, 1),
        )),
        child: MaterialButton(
          onPressed: () {},
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(AppImages.addRoomPlusIcon),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'Add New Room',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 14,
                    color: Color.fromRGBO(192, 192, 192, 1),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
