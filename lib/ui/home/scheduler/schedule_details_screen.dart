import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/src_components.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_dropdown.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/data/remote/model/rooms/rooms_response.dart';
import 'package:estonedge/ui/home/scheduler/schedule_details_screen_bloc.dart';
import 'package:estonedge/ui/home/scheduler/schedule_time_screen.dart';
import 'package:estonedge/utils/shared_pref.dart';
import 'package:flutter/material.dart';

import '../../../base/src_constants.dart';

class ScheduleDetailsScreen extends BasePage {
  const ScheduleDetailsScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _ScheduleDetailsScreenState();

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const ScheduleDetailsScreen());
  }
}

class _ScheduleDetailsScreenState
    extends BasePageState<ScheduleDetailsScreen, ScheduleDetailsScreenBloc> {
  ScheduleDetailsScreenBloc _bloc = ScheduleDetailsScreenBloc();

  @override
  ScheduleDetailsScreenBloc getBloc() => _bloc;

  List<String> roomList = ['room1', 'room2', 'room3', 'room4'];
  List<String> boardList = ['board1', 'board2', 'board3', 'board4'];
  List<String> switchList = ['switch1', 'switch2', 'switch3', 'switch4'];

  String? selectedRoom;
  String? selectedBoard;
  String? selectedSwitch;

  @override
  void initState() {
    super.initState();
    selectedRoom = roomList.first;
    selectedBoard = boardList.first;
    selectedSwitch = switchList.first;
    //fetchRooms();
  }

  void fetchRooms() {
    List<RoomsResponse> rooms = getRoomsList();
    print("ROOMS : $rooms");
    roomList = rooms.map((room) => room.roomName).toList();
    selectedRoom = roomList.isNotEmpty ? roomList.first : null;
  }

  @override
  Widget? getAppBar() {
    return AppBar(
      centerTitle: true,
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
      title: const Text(
        overflow: TextOverflow.ellipsis,
        'Scheduler',
        style: fs24BlackBold,
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('Your Room', style: fs16BlackSemibold),
          CustomDropdown(
            initialValue: selectedRoom,
            hint: 'Room',
            items: roomList,
            onClick: (newValue) {
              setState(() {
                selectedRoom = newValue;
              });
            },
          ),
          SizedBox(height: 10.h),
          Text('Your Board', style: fs16BlackSemibold),
          CustomDropdown(
            initialValue: selectedBoard,
            hint: 'Room',
            items: boardList,
            onClick: (newValue) {
              setState(() {
                selectedBoard = newValue;
              });
            },
          ),
          SizedBox(height: 10.h),
          Text('Your Switch', style: fs16BlackSemibold),
          CustomDropdown(
            initialValue: selectedSwitch,
            hint: 'Room',
            items: switchList,
            onClick: (newValue) {
              setState(() {
                selectedSwitch = newValue;
              });
            },
          ),
          const Expanded(child: SizedBox()),
          Center(
            child: CustomButton(
              btnText: 'Select',
              color: Colors.blue,
              width: 250.0,
              onPressed: () async {
                await Future.delayed(const Duration(seconds: 2), () {
                  Navigator.push(context, ScheduleTimeScreen.route());
                });
              },
            ),
          ),
          SizedBox(height: 8.h),
          Center(
            child: CustomButton(
              btnText: 'Cancel',
              color: Colors.grey,
              width: 250.0,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
