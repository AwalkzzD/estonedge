import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/constants/app_styles.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_room_network_image.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/data/remote/model/rooms/rooms_response.dart';
import 'package:estonedge/ui/home/room/board/add_board_screen.dart';
import 'package:estonedge/ui/home/room/board/board_details_screen.dart';
import 'package:estonedge/ui/home/room/room_details/room_details_screen_bloc.dart';
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
                  Navigator.push(context, AddBoardScreen.route());
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
    final roomsList = widget.roomResponse;

    if (roomsList == null) {
      return const Center(
        child: Text('No Room Details Available'),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          imgStack(),
          const SizedBox(height: 20),
          if (roomsList.boards.isEmpty)
            buildNoBoards()
          else
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.6,
                ),
                itemCount: roomsList.boards.length,
                itemBuilder: (context, index) {
                  final board = roomsList.boards[index];
                  return boardCard(board.boardName, 1, 1);
                },
              ),
            ),
          const Spacer(),
          CustomButton(
            btnText: 'Delete Room',
            width: double.infinity,
            color: const Color.fromARGB(255, 237, 83, 83),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget imgStack() {
    final roomsList = widget.roomResponse;
    print(roomsList);

    if (roomsList == null) {
      return const SizedBox.shrink();
    }

    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: AspectRatio(
            aspectRatio: 21 / 9,
            child: buildCustomRoomNetworkImage(imageUrl: roomsList.roomImage),
          ),
        ),
        Positioned(
          left: 20,
          top: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                roomsList.roomName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${roomsList.boards.length} boards found',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget boardCard(String boardName, int activeCount, int inactiveCount) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, BoardDetailsScreen.route(isFromRoomDetailsScreen: true));
      },
      child: Container(
        width: 150,
        height: 80,
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Text(boardName, style: fs12WhiteSemibold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Active', style: fs12BlackRegular),
                      Text(activeCount.toString(), style: fs12BlackRegular),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Inactive', style: fs12BlackRegular),
                      Text(inactiveCount.toString(), style: fs12BlackRegular),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNoBoards() {
    print(widget.roomResponse);
    return const Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              left: 100.0, right: 100.0, top: 100.0, bottom: 30.0),
          child: Image(image: AssetImage(AppImages.noRoomFoundImage)),
        ),
        SizedBox(height: 30),
        Text(
          'No Boards',
          style: fs22BlackMedium,
        ),
        Text(
          'Add your board by clicking plus(+) icon',
          style: fs14BlackRegular,
        ),
      ],
    );
  }
}
