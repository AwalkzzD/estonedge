import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_widgets.dart';
import 'package:estonedge/base/utils/widgets/custom_appbar.dart';
import 'package:estonedge/data/remote/model/rooms/get_rooms/rooms_response.dart';
import 'package:estonedge/ui/home/dashboard/dashboard_screen_bloc.dart';
import 'package:estonedge/ui/home/room/add_room/room_name/add_room_screen.dart';
import 'package:estonedge/utils/shared_pref.dart';
import 'package:flutter/material.dart';

import '../../../base/src_constants.dart';

class DashboardScreen extends BasePage {
  const DashboardScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _DashboardScreenState();

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const DashboardScreen());
  }
}

class _DashboardScreenState
    extends BasePageState<DashboardScreen, DashboardScreenBloc> {
  final DashboardScreenBloc _bloc = DashboardScreenBloc();

  List<bool> switchStates = List.generate(10, (index) => false);

  @override
  void onReady() {
    getBloc().getRooms();
    super.onReady();
  }

  @override
  bool isRefreshEnable() => true;

  @override
  Future<void> onRefresh() async {
    return getBloc().getRooms();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return StreamBuilder<List<RoomsResponse>>(
      stream: getBloc().roomListStream,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          if (snapshot.data!.isNotEmpty) {
            /// change to return frequentlyUsed()
            print('NOTOK');
            print(snapshot.data?.length);
            return const Center(
              child: SizedBox(
                child: Text('Show Frequently Used'),
              ),
            );
          } else {
            print('OK');
            print(snapshot.data?.length);
            return addRoomButton();
          }
        } else {
          return const SizedBox();
        }
      },
    );
  }

  @override
  DashboardScreenBloc getBloc() => _bloc;

  Widget addRoomButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30, top: 40),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          style: BorderStyle.solid,
          color: const Color.fromRGBO(192, 192, 192, 1),
        )),
        child: MaterialButton(
          onPressed: () {
            // Navigator.pushNamed(context, '/addRoom');
            Navigator.push(context, AddRoomScreen.route());
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(AppImages.addRoomPlusIcon),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  'Add New Room',
                  style: fs14GrayRegular,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget frequentlyUsed(List<String> roomList) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Frequently Used',
              style: fs20BlackBold,
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: roomList.length, // Total number of rooms
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 containers per row
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.3, // Adjust the aspect ratio if needed
              ),
              itemBuilder: (context, index) {
                // Replace these values with your actual device data
                Icon deviceImage = const Icon(Icons.lightbulb);
                String deviceName = roomList[index];
                int totalDevices = 5;

                return customContainer(
                  deviceImage: deviceImage,
                  deviceName: deviceName,
                  totalDevices: totalDevices,
                  isSwitched: switchStates[index],
                  onToggle: (value) {
                    setState(() {
                      switchStates[index] = value;
                    });
                  },
                );
              },
            ),
          ),
          addRoomButton(),
        ],
      ),
    );
  }

  Widget customContainer({
    required Icon deviceImage,
    required String deviceName,
    required int totalDevices,
    required bool isSwitched,
    required Function(bool) onToggle,
  }) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Adjust to fit content
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              deviceImage,
              Switch(
                activeThumbImage:
                    const AssetImage(AppImages.switchActiveThumbImage),
                inactiveThumbImage:
                    const AssetImage(AppImages.switchInactiveThumbImage),
                activeTrackColor: Colors.blueAccent,
                inactiveTrackColor: Colors.black,
                value: isSwitched,
                onChanged: onToggle,
              ),
            ],
          ),
          Text(overflow: TextOverflow.fade, deviceName, style: fs16BlackBold),
          Text(
              overflow: TextOverflow.ellipsis,
              'Total devices: $totalDevices',
              style: fs14GrayRegular),
        ],
      ),
    );
  }
}
