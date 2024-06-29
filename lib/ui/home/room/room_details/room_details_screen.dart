import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_components.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/src_widgets.dart';
import 'package:estonedge/base/theme/app_theme.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_room_network_image.dart';
import 'package:estonedge/data/remote/model/rooms/get_rooms/rooms_response.dart';
import 'package:estonedge/ui/home/room/board/add_board/add_board_screen.dart';
import 'package:estonedge/ui/home/room/room_details/room_details_screen_bloc.dart';
import 'package:estonedge/ui/home/room/room_details/widgets/board_item_widget.dart';
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
                if (snapshot.data!.boards.isEmpty) ...[
                  Expanded(child: buildNoBoards())
                ],
                if (snapshot.data!.boards.isNotEmpty) ...[
                  Expanded(
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.boards.length,
                      itemBuilder: (context, index) {
                        return BoardItemWidget(
                          roomId: widget.roomResponse?.roomId,
                          board: snapshot.data?.boards[index],
                          onDeleteBoardPress: () {
                            getBloc().deleteBoard(widget.roomResponse!.roomId,
                                snapshot.data!.boards[index].boardId,
                                (response) {
                              showMessageBar(response.message ??
                                  'Board deleted successfully!');
                              showRefreshIndicator();
                              onRefresh();
                            }, (errorMsg) {
                              showMessageBar(errorMsg);
                            });
                          },
                          onUpdateBoardPress: (boardName, macAddress) {
                            getBloc().updateBoard(
                                widget.roomResponse!.roomId,
                                snapshot.data!.boards[index].boardId,
                                boardName,
                                macAddress, (response) {
                              showMessageBar(
                                  response.message ?? "Board Name Updated");
                              showRefreshIndicator();
                              onRefresh();
                            }, (errorMsg) {
                              showMessageBar(errorMsg);
                            });
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(height: 10.h),
                    ),
                  ),
                ],
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

  void navigateToRoomScreen() {
    Navigator.pop(context, "roomDeleted");
  }

  /*void showCustomDialog({
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
  }*/

  void deleteRoom(String roomId) {
    getBloc().deleteRoom(roomId, (response) {
      navigateToRoomScreen();
      showMessageBar(response.message ?? 'Room Deleted Successfully');
    }, (errorMsg) {
      showMessageBar(errorMsg);
    });
  }

  @override
  void dispose() {
    boardNameController.dispose();
    getBloc().roomDetails.close();
    super.dispose();
  }
}
