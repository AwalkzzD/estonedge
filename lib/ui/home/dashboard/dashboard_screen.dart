import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/screens/base_widget.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends BaseWidget {
  const DashboardScreen({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _DashboardScreenState();
}

class _DashboardScreenState extends BaseWidgetState<DashboardScreen> {
  bool isRoomAdded = false;
  List<bool> switchStates = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Visibility(
          visible: isRoomAdded,
          replacement: addRoomButton(),
          child: frequentlyUsed(),
        ),
      ),
    );
  }

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
            setState(() {
              isRoomAdded = !isRoomAdded;
            });
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
                const Text(
                  'Add New Room',
                  style: TextStyle(
                    fontFamily: 'Lexend',
                    fontSize: 14,
                    color: Color.fromRGBO(192, 192, 192, 1),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget frequentlyUsed() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Frequently Used',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RubikMedium-DRPE',
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: 5, // Total number of containers
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 containers per row
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1.3, // Adjust the aspect ratio if needed
              ),
              itemBuilder: (context, index) {
                // Replace these values with your actual device data
                Icon deviceImage = const Icon(Icons.lightbulb);
                String deviceName = 'Device ${index + 1}';
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
          addRoomButton()
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
          Text(
            overflow: TextOverflow.fade,
            deviceName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Text(
            overflow: TextOverflow.ellipsis,
            'Total devices: $totalDevices',
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
