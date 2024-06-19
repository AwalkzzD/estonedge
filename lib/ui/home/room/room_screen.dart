import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/data/remote/model/rooms/rooms_response.dart';
import 'package:estonedge/ui/home/room/room_screen_bloc.dart';
import 'package:flutter/material.dart';

import '../../../base/src_constants.dart';

/*
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
  return const Column(
    children: [
      SizedBox(height: 100),
      Image(image: AssetImage(AppImages.noRoomFoundImage)),
      SizedBox(height: 30),
      Text(
        'No Rooms',
        style: TextStyle(
            fontSize: 22, fontFamily: 'Lexend', fontWeight: FontWeight.w500),
      ),
      Text(
        'add your room by clicking plus(+) icon',
        style: TextStyle(fontSize: 15, fontFamily: 'Lexend'),
      )
    ],
  );
}

Widget RoomList(Map<String, String> roomList) {
  return ListView.builder(
    itemCount: roomList.length,
    itemBuilder: (context, index) {
      final roomName = roomList.keys.elementAt(index);
      final roomImage = roomList.values.elementAt(index);
      return Card(
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
                  padding: const EdgeInsets.only(left: 10, top: 10),
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
      );
    },
  );
}
*/

class RoomScreen extends BasePage {
  const RoomScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _RoomScreenState();
}

class _RoomScreenState extends BasePageState<RoomScreen, RoomScreenBloc> {
  final RoomScreenBloc _bloc = RoomScreenBloc();

  @override
  void initState() {
    getRoomsData();
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return StreamBuilder<List<RoomsResponse>>(
      stream: getBloc().roomListStream,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          if (snapshot.data!.isNotEmpty) {
            return RoomList(snapshot.data!);
          } else {
            return NoRoomFound();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }

  @override
  RoomScreenBloc getBloc() => _bloc;

  Widget NoRoomFound() {
    return const Column(
      children: [
        SizedBox(height: 100),
        Image(image: AssetImage(AppImages.noRoomFoundImage)),
        SizedBox(height: 30),
        Text(
          'No Rooms',
          style: TextStyle(
              fontSize: 22, fontFamily: 'Lexend', fontWeight: FontWeight.w500),
        ),
        Text(
          'add your room by clicking plus(+) icon',
          style: TextStyle(fontSize: 15, fontFamily: 'Lexend'),
        )
      ],
    );
  }

  Widget RoomList(List<RoomsResponse> roomsList) {
    return ListView.builder(
      itemCount: roomsList.length,
      itemBuilder: (context, index) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                      child: const AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image(
                          image: AssetImage(AppImages.roomDummyImage),
                          fit: BoxFit.fill, // use this
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Wrap(
                      direction: Axis.vertical,
                      children: [
                        Text(
                          roomsList[index].roomName,
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
        );
      },
    );
  }

  void getRoomsData() {
    getBloc().getRooms();
  }
}
