import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/ui/home/room/switch/switch_details_screen_bloc.dart';
import 'package:estonedge/ui/home/room/switch/widget/switch_item_widget.dart';
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
  final SwitchDetailsScreenBloc _bloc = SwitchDetailsScreenBloc();

  @override
  SwitchDetailsScreenBloc getBloc() => _bloc;

  List<String> roomList = ['room1', 'room2', 'room3'];

  List<bool> switchStates = List.generate(10, (index) => false);

  @override
  Widget? getAppBar() {
    return AppBar(
      centerTitle: true,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Image.asset(AppImages.appBarBackIcon),
            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      ),
      title: const Text(
        'Switch Details',
        style: fs24BlackBold,
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return frequentlyUsed(roomList);
  }

  Widget frequentlyUsed(List<String> roomList) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text('Switch Details', style: fs20BlackSemibold),
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
                String deviceImage = AppImages.switchIcon;
                String deviceName = roomList[index];
                int totalDevices = 5;

                return GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/addDevice');
                    // Navigator.push(context, AddDeviceScreen.route());
                  },
                  child: SwitchItemWidget(deviceImage, deviceName, totalDevices,
                      switchStates[index], (value) {}),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
