import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/screens/base_widget.dart';
import 'package:estonedge/ui/home/room/add_room/room_list_provider.dart';
import 'package:estonedge/ui/home/room/room_details/room_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RoomScreen extends BaseWidget {
  const RoomScreen({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _RoomScreenState();
}

class _RoomScreenState extends BaseWidgetState<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, child) {
          final roomList = ref.watch(roomListProvider);
          return roomList.isEmpty ? NoRoomFound() : RoomList(roomList);
        },
      ),
    );
  }
}

Widget NoRoomFound() {
  return Column(children: [
    const SizedBox(height: 100),
    Image.asset(AppImages.noRoomFoundImage),
    const SizedBox(height: 30),
    const Text(
      'No Rooms',
      style: TextStyle(
          fontSize: 22, fontFamily: 'Lexend', fontWeight: FontWeight.w500),
    ),
    const Text(
      ' add your room by clicking plus(+) icon',
      style: TextStyle(fontSize: 15, fontFamily: 'Lexend'),
    )
  ]);
}

Widget RoomList(Map<String, String> roomList) {
  return ListView.builder(
    itemCount: roomList.length,
    itemBuilder: (context, index) {
      final roomName = roomList.keys.elementAt(index);
      final roomImage = roomList.values.elementAt(index);
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RoomDetailsScreen(
                roomName: roomName,
                roomImage: roomImage,
              ),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          margin: const EdgeInsets.all(30),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image(
                          image: AssetImage(roomImage),
                          fit: BoxFit.fill, // use this
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Wrap(
                      direction: Axis.vertical,
                      children: [
                        Text(
                          roomName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        const Text(
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
                        backgroundColor: Colors.white, child: Icon(Icons.air)),
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
        ),
      );
    },
  );
}
