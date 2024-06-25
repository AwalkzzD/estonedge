import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/constants/app_styles.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/ui/add_device/macid/macid_screen.dart';
import 'package:estonedge/ui/add_device/qr_scanner/qr_screen.dart';
import 'package:flutter/material.dart';

class AddDeviceScreen extends StatelessWidget {
  const AddDeviceScreen({super.key});

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const AddDeviceScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Add your devices', style: fs24BlackBold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            DeviceOptionCard(
              icon: AppImages.addDeviceQR,
              title: 'Scan QR Code',
              subtitle: 'Scan the QR code to add smart device',
              onTap: () {
                Navigator.push(context, QrScreen.route());
              },
            ),
            const SizedBox(height: 20),
            DeviceOptionCard(
              icon: AppImages.addDeviceManually,
              title: 'Enter manually',
              subtitle: 'Enter Mac ID of smart device',
              onTap: () {
                // Navigator.pushNamed(context, '/macIdScreen');
                Navigator.push(context, MacidScreen.route());
              },
            ),
          ],
        ),
      ),
    );
  }
}

class DeviceOptionCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const DeviceOptionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.blue),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.all(15.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(icon),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: fs18BlackBold),
                  const SizedBox(height: 5),
                  Text(subtitle, style: fs14BlackRegular),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
