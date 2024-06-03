import 'package:flutter/material.dart';

class FrequentlyUsedScreen extends StatefulWidget {
  const FrequentlyUsedScreen({super.key});

  @override
  State<FrequentlyUsedScreen> createState() => _FrequentlyUsedScreenState();
}

class _FrequentlyUsedScreenState extends State<FrequentlyUsedScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 25, left: 18),
      child: Column(
        children: [
          const Text(
            'Frequently Used',
            style: TextStyle(
              fontSize: 20,
              fontFamily: 'RubikMedium-DRPE',
            ),
          ),
          SizedBox(
            height: 400,
            child: GridView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: 10, // Total number of containers
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 containers per row
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                // Replace these values with your actual device data
                Icon deviceImage = const Icon(Icons.lightbulb);
                String deviceName = 'Device ${index + 1}';
                int totalDevices = 5;

                return CustomContainer(deviceImage, deviceName, totalDevices);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget CustomContainer(
      Icon deviceImage, String deviceName, int totalDevices) {
    bool isSwitched = false;
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(8.0),
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
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              deviceImage,
              Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value; // Update switch state
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            deviceName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 4.0),
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
