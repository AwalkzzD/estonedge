import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/constants/app_styles.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/ui/home/room/switch/switch_details_screen_bloc.dart';
import 'package:flutter/material.dart';

class SwitchDetailsScreen extends BasePage {
  const SwitchDetailsScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _SwitchDetailsScreenState();

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const SwitchDetailsScreen());
  }
}

class _SwitchDetailsScreenState
    extends BasePageState<SwitchDetailsScreen, SwitchDetailsScreenBloc> {
  SwitchDetailsScreenBloc _bloc = SwitchDetailsScreenBloc();

  @override
  SwitchDetailsScreenBloc getBloc() => _bloc;
  List<String> roomList = ['room1', 'room2', 'room3'];

  List<bool> switchStates = List.generate(10, (index) => false);

  @override
  Widget? getAppBar() {
    return AppBar(
      title: Center(
          child: Text(
        'Switch Details',
        style: fs24BlackSemibold,
      )),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      body: frequentlyUsed(roomList),
    );
  }

  Widget frequentlyUsed(List<String> roomList) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Board Details', style: fs20BlackSemibold),
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

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/addDevice');
                  },
                  child: customContainer(
                    deviceImage: deviceImage,
                    deviceName: deviceName,
                    totalDevices: totalDevices,
                    isSwitched: switchStates[index],
                    onToggle: (value) {
                      // setState(() {
                      //   switchStates[index] = value;
                      // });
                    },
                  ),
                );
              },
            ),
          ),
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
          Row(
            children: [
              Text(
                overflow: TextOverflow.fade,
                deviceName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
              Spacer(),
              PopupMenuButton<String>(
                onSelected: (value) {
                  // Handle menu item selection
                  if (value == 'Edit') {
                    // Handle edit action
                  } else if (value == 'Favorite') {
                    // Handle delete action
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
                    value: 'Favorite',
                    child: ListTile(
                      leading: Icon(Icons.favorite),
                      title: Text('Favorite'),
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
            ],
          ),
        ],
      ),
    );
  }
}
