import 'package:estonedge/base/constants/app_styles.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/ui/add_device/macid/macid_screen.dart';
import 'package:estonedge/ui/add_device/qr_scanner/qr_screen.dart';
import 'package:flutter/material.dart';

class AddDeviceScreen extends StatelessWidget {
   static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => AddDeviceScreen());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text(
          'Add your devices',
          style: fs24BlackSemibold,
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DeviceOptionCard(
              icon: Icons.qr_code_scanner,
              title: 'Scan QR Code',
              subtitle: 'Scan the QR code to add smart device',
              onTap: () {
                // Navigator.pushNamed(context, '/qrScanner');
                Navigator.push(context, QrScreen.route());
              },
            ),
            SizedBox(height: 20),
            DeviceOptionCard(
              icon: Icons.input,
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
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  DeviceOptionCard({
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
        side: BorderSide(color: Colors.blue),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.blue),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
