import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_components.dart';
import 'package:estonedge/base/src_widgets.dart';
import 'package:estonedge/base/theme/app_theme.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/data/remote/model/user/user_response.dart'
    as user_model;
import 'package:estonedge/ui/home/room/room_details/widgets/board_item_widget_bloc.dart';
import 'package:estonedge/ui/home/room/switch/switch_details_screen.dart';
import 'package:estonedge/ui/profile/profile_details/profile_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../base/src_constants.dart';

class BoardItemWidget extends BasePage {
  final user_model.Board? board;
  final String? roomId;

  const BoardItemWidget(this.roomId, this.board, {super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _BoardItemWidgetState();
}

class _BoardItemWidgetState
    extends BasePageState<BoardItemWidget, BoardItemWidgetBloc> {
  bool boardStatus = true;

  final TextEditingController boardNameController = TextEditingController();

  user_model.Board? board;

  @override
  void initState() {
    board = widget.board;
    super.initState();
  }

  @override
  Widget buildWidget(BuildContext context) {
    if (board != null && board!.switches.isNotEmpty) {
      print('Building this');
      boardStatus = board!.switches.any((switch1) => switch1.status);
    }
    return Card(
      child: Container(
        decoration: BoxDecoration(
            color: white,
            border: Border.all(color: themeOf().primaryColor, width: 2),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  board?.boardName ?? '',
                  style: fs16BlackSemibold.copyWith(fontWeight: medium),
                ),
              ),
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
                            widget.roomId ?? '',
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
                        deleteBoard(widget.roomId ?? '', board?.boardId ?? '');
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
              if (board != null && board!.macAddress.isEmpty)
                IconButton(
                  onPressed: () {
                    navigateToSwitchScreen();
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
                      if (board != null && board!.switches.isNotEmpty) {
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

  @override
  BoardItemWidgetBloc getBloc() {
    // TODO: implement getBloc
    throw UnimplementedError();
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

  void navigateToSwitchScreen() async {
    final result = await Navigator.push(
      context,
      SwitchDetailsScreen.route(),
    );

    print('Navigator result = ${result.toString()}');
  }

  void navigateToRoomScreen() {
    Navigator.pop(context, "roomDeleted");
  }
}
