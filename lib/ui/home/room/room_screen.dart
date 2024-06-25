import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/src_components.dart';
import 'package:estonedge/base/utils/widgets/custom_room_network_image.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/data/remote/model/rooms/rooms_response.dart';
import 'package:estonedge/ui/home/room/room_details/room_details_screen.dart';
import 'package:estonedge/ui/home/room/room_screen_bloc.dart';
import 'package:flutter/material.dart';

import '../../../base/src_constants.dart';

class RoomScreen extends BasePage {
  const RoomScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _RoomScreenState();

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const RoomScreen());
  }
}

class _RoomScreenState extends BasePageState<RoomScreen, RoomScreenBloc> {
  final RoomScreenBloc _bloc = RoomScreenBloc();

  @override
  void onReady() {
    getRoomsData();
    super.onReady();
  }

  @override
  bool isRefreshEnable() {
    return true;
  }

  @override
  Future<void> onRefresh() async {
    return getRoomsData();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return StreamBuilder<List<RoomsResponse>>(
      stream: getBloc().roomListStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isNotEmpty) {
            return buildRoomList(snapshot.data!);
          } else {
            return noRoomFound();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }

  @override
  RoomScreenBloc getBloc() => _bloc;

  Widget noRoomFound() {
    return const Column(
      children: [
        SizedBox(height: 100),
        Image(image: AssetImage(AppImages.noRoomFoundImage)),
        SizedBox(height: 30),
        Text(
          'No Rooms',
          style: fs22BlackMedium,
        ),
        Text(
          'add your room by clicking plus(+) icon',
          style: fs14BlackRegular,
        )
      ],
    );
  }

  Widget buildRoomList(List<RoomsResponse> roomsList) {
    return ListView.separated(
      padding: EdgeInsets.only(bottom: 100.h),
      itemCount: roomsList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
              context, RoomDetailsScreen.route(roomsList[index])),
          child: Card(
            shadowColor: Colors.black,
            elevation: 10,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 5),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20)),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20)),
                          child: AspectRatio(
                            aspectRatio: 21 / 9,
                            child: buildCustomRoomNetworkImage(
                                useColorFiltered: true,
                                imageUrl: roomsList[index].roomImage),
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
                          Text(
                            '${roomsList[index].boards.length} boards',
                            style: fs14WhiteMedium.copyWith(fontWeight: bold),
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
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) =>
          SizedBox(height: 20.h),
    );
  }

  void getRoomsData() {
    getBloc().getRooms();
  }
}