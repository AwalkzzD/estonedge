import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/ui/home/room/board/add_board/add_board_screen.dart';
import 'package:estonedge/ui/home/room/board/board_details/board_details_screen_bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../base/src_constants.dart';
import '../../../../../base/src_widgets.dart';
import '../../switch/switch_details_screen.dart';

class BoardDetailsScreen extends BasePage {
  const BoardDetailsScreen({super.key, required this.isFromRoomDetailsScreens});

  final bool isFromRoomDetailsScreens;

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _BoardDetailsScreenState();

  static Route<dynamic> route({required bool isFromRoomDetailsScreen}) =>
      CustomPageRoute(
          builder: (context) => BoardDetailsScreen(
              isFromRoomDetailsScreens: isFromRoomDetailsScreen));
}

class _BoardDetailsScreenState
    extends BasePageState<BoardDetailsScreen, BoardDetailsScreenBloc> {
  final BoardDetailsScreenBloc _bloc = BoardDetailsScreenBloc();

  final List<String> boards = ['Board 1', 'Board 2', 'Board 3'];

  @override
  Widget? getAppBar() {
    return AppBar(
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
      centerTitle: true,
      backgroundColor: Colors.white,
      title: const Text(
        'Board Details',
        style: fs24BlackSemibold,
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Board', style: fs16BlackSemibold),
              TextButton(
                onPressed: () {
                  if (widget.isFromRoomDetailsScreens) {
                  } else {
                    Navigator.pop(context);
                  }
                  // Handle add board action
                },
                child: TextButton(
                    onPressed: () {},
                    child: Text('+ Add Board', style: fs16BlueRegular)),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: boards.length,
              itemBuilder: (context, index) {
                return buildBoardItem();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBoardItem() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text('boardName'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PopupMenuButton<String>(
              onSelected: (value) {
                // Handle menu item selection
                if (value == 'Edit') {
                  // Handle edit action
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
            IconButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/switchDetails');
                  // Navigator.push(context, SwitchDetailsScreen.route());
                },
                icon: Image.asset(AppImages.boardConfigIcon)),
          ],
        ),
      ),
    );
  }

  @override
  BoardDetailsScreenBloc getBloc() => _bloc;
}
