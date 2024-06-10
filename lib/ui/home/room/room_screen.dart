import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/screens/base_widget.dart';
import 'package:flutter/material.dart';

class RoomScreen extends BaseWidget {
  const RoomScreen({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _RoomScreenState();
}

class _RoomScreenState extends BaseWidgetState<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.all(30),
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(AppImages.roomDummyImage, fit: BoxFit.fill),
                    const Padding(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Wrap(
                        direction: Axis.vertical,
                        children: [
                          Text(
                            'Living Room',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '3/3',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: const Row(
                    children: [
                      SizedBox(
                        width: 10,
                        height: 60,
                      ),
                      CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.air)),
                      SizedBox(width: 10),
                      CircleAvatar(
                          backgroundColor: Colors.white, child: Icon(Icons.tv)),
                      SizedBox(width: 10),
                      CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.lightbulb_outline)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        itemCount: 6,
      ),
    );
  }
}
