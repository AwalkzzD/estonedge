import 'package:estonedge/base/src_components.dart';
import 'package:estonedge/base/src_widgets.dart';
import 'package:estonedge/base/theme/app_theme.dart';
import 'package:estonedge/data/remote/model/user/user_response.dart'
    as user_model;
import 'package:estonedge/ui/add_device/add_your_device_screen.dart';
import 'package:estonedge/ui/profile/profile_details/profile_details_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../base/src_constants.dart';

class BoardItemWidget extends StatefulWidget {
  final user_model.Board? board;
  final String? roomId;

  final Function()? onDeleteBoardPress;
  final Function(String boardName, String macAddress)? onUpdateBoardPress;

  const BoardItemWidget({
    this.roomId,
    this.board,
    this.onDeleteBoardPress,
    this.onUpdateBoardPress,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => _BoardItemWidgetState();
}

class _BoardItemWidgetState extends State<BoardItemWidget> {
  bool boardStatus = true;

  final TextEditingController boardNameController = TextEditingController();

  user_model.Board? board;

  @override
  void initState() {
    board = widget.board;
    super.initState();
  }

  void navigateToAddDeviceScreen() async {
    final result = await Navigator.push(
      context,
      AddDeviceScreen.route(),
    );
  }

  void navigateToRoomScreen() {
    Navigator.pop(context, "roomDeleted");
  }

  @override
  Widget build(BuildContext context) {
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
                elevation: 10,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: themeOf().primaryColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
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
                        widget.onUpdateBoardPress!(
                            boardNameController.text, board!.macAddress);
                      },
                    );
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
                      onButtonPress: () => widget.onDeleteBoardPress,
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
                  onPressed: () => navigateToAddDeviceScreen(),
                  icon: const ImageView(
                      image: AppImages.boardConfigIcon,
                      imageType: ImageType.asset),
                )
              else
                Switch(
                  trackOutlineColor:
                      WidgetStateProperty.all(Colors.transparent),
                  trackOutlineWidth: WidgetStateProperty.all(0),
                  thumbColor: WidgetStateProperty.all(white),
                  activeThumbImage:
                      const AssetImage(AppImages.switchActiveThumbImage),
                  inactiveThumbImage:
                      const AssetImage(AppImages.switchInactiveThumbImage),
                  activeTrackColor: themeOf().primaryColor,
                  inactiveTrackColor: black,
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
}
