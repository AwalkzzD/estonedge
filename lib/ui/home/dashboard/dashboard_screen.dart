import 'package:estonedge/base/constants/app_images.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  /// 0 -> For showing Add new Room Button
  /// 1 -> For showing frequently used data
  int flag = 0;
  List<bool> switchStates = List.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: flag == 0 ? addRoomButton() : frequentlyUsed(),
    );
  }

  Widget addRoomButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 40),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
          style: BorderStyle.solid,
          color: const Color.fromRGBO(192, 192, 192, 1),
        )),
        child: MaterialButton(
          onPressed: () {},
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
      padding: EdgeInsets.only(top: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            child: const Text(
              'Frequently Used',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RubikMedium-DRPE',
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 480,
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: 10, // Total number of containers
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
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Adjust to fit content
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              deviceImage,
              Switch(
                thumbColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.orange.withOpacity(.48);
                  }
                  return Colors.white;
                }),
                activeColor: Colors.blueAccent,
                // activeTrackColor: Colors.pink,
                trackOutlineColor: WidgetStateProperty.resolveWith<Color?>(
                    (Set<WidgetState> states) {
                  return Colors.white; // Use the default color.
                }),
                value: isSwitched,
                onChanged: onToggle,
              ),
            ],
          ),
          SizedBox(height: 8.0), // Reduced height
          Text(
            deviceName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 8.0), // Reduced height
          Text(
            'Total devices: $totalDevices',
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
