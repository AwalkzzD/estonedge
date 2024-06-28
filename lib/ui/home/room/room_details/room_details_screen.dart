import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_components.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_room_network_image.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/data/remote/model/rooms/get_rooms/rooms_response.dart';
import 'package:estonedge/data/remote/model/user/user_response.dart'
    as userModel;
import 'package:estonedge/ui/home/home_screen.dart';
import 'package:estonedge/ui/home/room/board/add_board/add_board_screen.dart';
import 'package:estonedge/ui/home/room/room_details/room_details_screen_bloc.dart';
import 'package:estonedge/ui/home/room/switch/switch_details_screen.dart';
import 'package:estonedge/ui/profile/profile_details/profile_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../../base/utils/widgets/custom_appbar.dart';

class RoomDetailsScreen extends BasePage {
  final RoomsResponse? roomResponse;

  const RoomDetailsScreen({
    this.roomResponse,
    super.key,
  });

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _RoomDetailsScreenState();

  static Route<dynamic> route(RoomsResponse? roomResponse) {
    return CustomPageRoute(
        builder: (context) => RoomDetailsScreen(roomResponse: roomResponse));
  }
}

class _RoomDetailsScreenState
    extends BasePageState<RoomDetailsScreen, RoomDetailsScreenBloc> {
  final RoomDetailsScreenBloc _bloc = RoomDetailsScreenBloc();

  RoomsResponse? roomsList;

  bool boardStatus = true;

  final TextEditingController boardNameController = TextEditingController();

  @override
  bool isRefreshEnable() {
    return true;
  }

  @override
  void onReady() {
    getBloc().getRoomData(widget.roomResponse?.roomId ?? '', (errorMsg) {
      showMessageBar(errorMsg);
    });
    super.onReady();
  }

  @override
  Future<void> onRefresh() async {
    return getBloc().getRoomData(widget.roomResponse?.roomId ?? '', (errorMsg) {
      showMessageBar(errorMsg);
    });
  }

  @override
  void initState() {
    roomsList = widget.roomResponse;
    super.initState();
  }

  @override
  RoomDetailsScreenBloc getBloc() => _bloc;

  @override
  Widget? getAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Image.asset(AppImages.appBarBackIcon),
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        },
      ),
      title: Builder(builder: (context) {
        return SafeArea(
          child: Column(
            children: <Widget>[
              CustomAppbar(
                centerTitle: true,
                context,
                title: widget.roomResponse?.roomName ?? 'Room Details',
                appBarTrailingImage: AppImages.appBarPlusIcon,
                trailingIconAction: () {
                  Navigator.push(
                      context, AddBoardScreen.route(roomsList!.roomId));
                },
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return StreamBuilder<RoomsResponse?>(
      stream: getBloc().roomDetailsStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                buildImageStack(snapshot.data),
                const SizedBox(height: 20),
                if (snapshot.data!.boards.isEmpty)
                  Expanded(child: buildNoBoards())
                else
                  Expanded(
                    child: ListView.separated(
                      itemCount: snapshot.data!.boards.length,
                      itemBuilder: (context, index) {
                        return buildBoardItem(snapshot.data?.boards[index]);
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(height: 10.h),
                    ),
                  ),
                CustomButton(
                  btnText: 'Delete Room',
                  width: double.infinity,
                  color: const Color.fromARGB(255, 237, 83, 83),
                  onPressed: () {
                    getBloc().deleteRoom(widget.roomResponse!.roomId,
                        (response) {
                      Navigator.pushAndRemoveUntil(
                          context, HomeScreen.route(), (route) => false);
                    }, (errorMsg) {
                      showMessageBar(errorMsg);
                    });
                  },
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }

  Widget buildImageStack(RoomsResponse? roomResponse) {
    if (roomResponse == null) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 21 / 9,
            child: buildCustomRoomNetworkImage(
                imageUrl: roomResponse.roomImage, useColorFiltered: true),
          ),
        ),
        Positioned(
          left: 20,
          top: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(roomResponse.roomName, style: fs18WhiteBold),
              Text('${roomResponse.boards.length} boards found',
                  style: fs16WhiteRegular),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildNoBoards() {
    print(widget.roomResponse);
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: 100.0, right: 100.0, top: 100.0, bottom: 60.0),
          child: Image(image: AssetImage(AppImages.noRoomFoundImage)),
        ),
        Text('No Boards', style: fs22BlackMedium),
        Text('Add your board by clicking plus(+) icon',
            style: fs14BlackRegular),
      ],
    );
  }

  Widget buildBoardItem(userModel.Board? board) {
    if (board != null && board.switches.isNotEmpty) {
      boardStatus = board.switches.any((switch1) => switch1.status);
    }
    return Card(
      child: Container(
        decoration: BoxDecoration(
            color: white,
            border: Border.all(color: Colors.blueAccent, width: 2),
            borderRadius: BorderRadius.circular(15)),
        child: ListTile(
          title: Text(
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            board?.boardName ?? '',
            style: fs16BlackSemibold.copyWith(fontWeight: medium),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  // Handle menu item selection
                  if (value == 'Edit') {
                    boardNameController.text = board?.boardName ?? 'Board X';
                    showDialog<String>(
                      barrierDismissible: true,
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomTextField(
                              hintText: 'Board Name',
                              controller: boardNameController,
                            ),
                          ],
                        ),
                        actions: <Widget>[
                          CustomButton(
                              width: MediaQuery.of(context).size.width,
                              btnText: 'Update',
                              color: Colors.blueAccent,
                              onPressed: () {
                                getBloc().updateBoard(
                                    widget.roomResponse!.roomId,
                                    board!.boardId,
                                    boardNameController.text, (response) {
                                  showMessageBar(
                                      response.message ?? "Board Name Updated");
                                }, (errorMsg) {
                                  showMessageBar(errorMsg);
                                });
                                Navigator.pop(context);
                              }),
                        ],
                      ),
                    );
                  } else if (value == 'Delete') {
                    // Handle delete action
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'Edit',
                    child: ListTile(
                      leading: Icon(Icons.edit),
                      title: Text('Edit'),
                    ),
                  ),
                  const PopupMenuItem(
                    value: 'Delete',
                    child: ListTile(
                      leading: Icon(Icons.delete),
                      title: Text('Delete'),
                    ),
                  ),
                ],
                icon: const Icon(Icons.more_vert),
              ),
              if (board != null && board.macAddress.isNotEmpty)
                IconButton(
                  onPressed: () {
                    // Handle the button press action
                    Navigator.push(
                      context,
                      SwitchDetailsScreen.route(),
                    );
                  },
                  icon: Image.asset(AppImages.boardConfigIcon),
                )
              else
                Switch(
                  trackOutlineColor:
                      WidgetStateProperty.all(Colors.transparent),
                  trackOutlineWidth: WidgetStateProperty.all(0),
                  thumbColor: WidgetStateProperty.all(Colors.white),
                  activeThumbImage:
                      const AssetImage(AppImages.switchActiveThumbImage),
                  inactiveThumbImage:
                      const AssetImage(AppImages.switchInactiveThumbImage),
                  activeTrackColor: Colors.blueAccent,
                  inactiveTrackColor: Colors.black,
                  value: boardStatus,
                  onChanged: (value) {
                    setState(() {
                      boardStatus = value;
                      if (board != null && board.switches.isNotEmpty) {
                        // Update the status of the first switch (or handle as needed)
                        // board.switches[0].status = value;
                      }
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
