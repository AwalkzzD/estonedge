import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/base/widgets/drop_down_list.dart';
import 'package:estonedge/data/remote/model/rooms/rooms_response.dart';
import 'package:estonedge/ui/home/scheduler/schedule_details_screen_bloc.dart';
import 'package:estonedge/ui/home/scheduler/schedule_time_screen.dart';
import 'package:estonedge/utils/shared_pref.dart';
import 'package:flutter/material.dart';

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

  ScheduleDetailsScreenBloc _bloc = ScheduleDetailsScreenBloc(); // Initialize the bloc

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
  Widget buildWidget(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 50, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ddl('Room', roomList, selectedRoom, (newValue) {
              setState(() {
                selectedRoom = newValue;
              });
            }),
            const SizedBox(height: 20),
            _ddl('Board', boardList, selectedBoard, (newValue) {
              setState(() {
                selectedBoard = newValue;
              });
            }),
            const SizedBox(height: 20),
            _ddl('Switch', switchList, selectedSwitch, (newValue) {
              setState(() {
                selectedSwitch = newValue;
              });
            }),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  btnText: 'Select',
                  width: 145.0,
                  color: Colors.blue,
                  onPressed: () async {
                    await Future.delayed(const Duration(seconds: 2), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              ScheduleTimeScreen(),
                        ),
                      );
                    });
                  },
                ),
                CustomButton(
                  btnText: 'Cancel',
                  width: 145.0,
                  color: Colors.grey,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      );    
  }

  Widget _buildRoomDropdown() {
    if (roomList.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return GenericDropdown(
        items: roomList,
        hint: 'Room',
        onChanged: (String? value) {
          // Handle the selected value
          print('Selected gender: $value');
          selectedRoom = value;
        },
      );
    }
  }

  Widget _ddl(String ddlName, List<String> items, String? selectedValue,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ddlName,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: DropdownButtonFormField<String>(
            isExpanded: true,
            value: selectedValue,
            onChanged: onChanged,
            items: items.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            decoration: InputDecoration.collapsed(hintText: ''),
          ),
        ),
      ],
    );
  }
}
