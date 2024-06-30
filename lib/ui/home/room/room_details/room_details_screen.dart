import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_components.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/src_widgets.dart';
import 'package:estonedge/base/theme/app_theme.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_room_network_image.dart';
import 'package:estonedge/data/remote/model/rooms/get_rooms/rooms_response.dart';
import 'package:estonedge/data/remote/model/user/user_response.dart'
    as user_model;
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

  RoomsResponse? roomData;

  bool boardStatus = true;

  final TextEditingController boardNameController = TextEditingController();

  @override
  bool isRefreshEnable() {
    return true;
  }

  @override
  void onReady() {
    roomData = widget.roomResponse;
    getBloc().getRoomData(widget.roomResponse?.roomId ?? '', (errorMsg) {
      showMessageBar(errorMsg);
    });
  }

  @override
  Future<void> onRefresh() async {
    return getBloc().getRoomData(widget.roomResponse?.roomId ?? '', (errorMsg) {
      showMessageBar(errorMsg);
    });
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
                trailingIconAction: () async {
                  final boardAddedResult = await Navigator.push(
                      context, AddBoardScreen.route(roomData!.roomId));
                  if (boardAddedResult != null) {
                    showRefreshIndicator();
                    onRefresh();
                  }
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
                  color: themeOf().redAccent,
                  onPressed: () {
                    showCustomDialog(
                        context: context,
                        children: [
                          ImageView(
                              color: themeOf().redAccent,
                              width: 80,
                              height: 80,
                              image: AppImages.icDelete,
                              imageType: ImageType.asset),
                          const SizedBox(height: 30),
                          Text(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              'Are you sure you want to delete ${roomData?.roomName} ?',
                              overflow: TextOverflow.ellipsis,
                              style: fs14BlackRegular)
                        ],
                        buttonText: 'Delete',
                        onButtonPress: () {
                          deleteRoom(widget.roomResponse!.roomId);
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

  Widget buildBoardItem(user_model.Board? board) {
    if (board != null && board.switches.isNotEmpty) {
      boardStatus = board.switches.any((switch1) => switch1.status);
    }
    return Card(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            SwitchDetailsScreen.route(board!),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: white,
              border: Border.all(color: themeOf().primaryColor, width: 2),
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
                    boardNameController.text = board?.boardName ?? 'Board X';
                    if (value == 'Edit') {
                      showCustomDialog(
                          context: context,
                          children: [
                            SizedBox(height: 10.h),
                            const Text(
                              'Board Name',
                              style: fs14BlackRegular,
                            ),
                            SizedBox(height: 8.h),
                            CustomTextField(
                              hintText: 'Enter Board Name...',
                              controller: boardNameController,
                            ),
                          ],
                          buttonText: 'Update',
                          onButtonPress: () {
                            updateBoard(
                              widget.roomResponse!.roomId,
                              board!.boardId,
                              boardNameController.text,
                            );
                          });
                    } else if (value == 'Delete') {
                      showCustomDialog(
                        context: context,
                        children: [
                          ImageView(
                              color: themeOf().redAccent,
                              width: 80,
                              height: 80,
                              image: AppImages.icDelete,
                              imageType: ImageType.asset),
                          const SizedBox(height: 30),
                          Text(
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              'Are you sure you want to delete ${boardNameController.text} ?',
                              overflow: TextOverflow.ellipsis,
                              style: fs14BlackRegular)
                        ],
                        buttonText: 'Delete',
                        buttonColor: themeOf().redAccent,
                        onButtonPress: () {
                          deleteBoard(widget.roomResponse!.roomId,
                              board?.boardId ?? '');
                        },
                      );
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
                  )
                else
                  Padding(
                    padding: const EdgeInsets.only(left: 11.0),
                    child: IconButton(
                      onPressed: () {
                        // Handle the button press action
                        Navigator.push(
                          context,
                          SwitchDetailsScreen.route(board!),
                        );
                      },
                      icon: Image.asset(AppImages.boardConfigIcon),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void navigateToRoomScreen() {
    Navigator.pop(context, "roomDeleted");
  }

  void showCustomDialog({
    required BuildContext context,
    required List<Widget> children,
    required String buttonText,
    Color buttonColor = Colors.blueAccent,
    required Function() onButtonPress,
  }) {
    showDialog<String>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: children,
        ),
        actions: <Widget>[
          CustomButton(
              btnText: buttonText,
              width: MediaQuery.of(context).size.width,
              color: buttonColor,
              onPressed: () {
                Navigator.pop(context);
                onButtonPress();
              })
        ],
      ),
    );
  }

  void deleteBoard(String roomId, String boardId) {
    getBloc().deleteBoard(roomId, boardId, (response) {
      showMessageBar(response.message ?? 'Board deleted successfully!');
      showRefreshIndicator();
      onRefresh();
    }, (errorMsg) {
      showMessageBar(errorMsg);
    });
  }

  void updateBoard(String roomId, String boardId, String boardName) {
    getBloc().updateBoard(roomId, boardId, boardName, (response) {
      showMessageBar(response.message ?? "Board Name Updated");
      showRefreshIndicator();
      onRefresh();
    }, (errorMsg) {
      showMessageBar(errorMsg);
    });
  }

  void deleteRoom(String roomId) {
    getBloc().deleteRoom(roomId, (response) {
      navigateToRoomScreen();
      showMessageBar(response.message ?? 'Room Deleted Successfully');
    }, (errorMsg) {
      showMessageBar(errorMsg);
    });
  }

  void navigateToSwitchScreen() async {
    // final result = await Navigator.push(
    //   context,
    //   SwitchDetailsScreen.route(),
    // );

    // print('Navigator result = ${result.toString()}');
  }

  @override
  void dispose() {
    boardNameController.dispose();
    getBloc().roomDetails.close();
    super.dispose();
  }
}
