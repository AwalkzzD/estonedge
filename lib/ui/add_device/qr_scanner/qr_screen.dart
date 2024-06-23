// ignore_for_file: unused_field

import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/ui/add_device/qr_scanner/qr_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:http/http.dart' as http;

import '../../../base/src_constants.dart';

class QrScreen extends BasePage {
  const QrScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _QrScreenState();

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const QrScreen());
  }
}

class _QrScreenState extends BasePageState<QrScreen, QrScreenBloc> {
  final QrScreenBloc _bloc = QrScreenBloc();
  String? _scanCode;
  bool _isFlashOn = false;  
  bool _isScanning = false;

  @override
  Widget? getAppBar() {
    return AppBar(
      backgroundColor: Colors.blue.shade300,
      centerTitle: true,
      title: const Text(
        'Scan QR Code',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            Text(
              'Scan QR Code of the smart device',
              style: fs18WhiteSemiBold,
              textAlign: TextAlign.center,
            ),
            Center(child: Image.asset(AppImages.qrCode)),
            Text(
              'The QR Code will be automatically detected when you position it between the guide lines',
              style: fs14WhiteMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            CustomButton(
                btnText: 'Link',
                color: white,
                // onPressed: () => scanQR(),
                onPressed: () => connectWifi(),
                textColor: Colors.blueAccent),
          ],
        ),
      ),
    );
  }

  Future<void> scanQR() async {
    setState(() {
      _isScanning = true;
    });

    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanCode = barcodeScanRes != '-1' ? barcodeScanRes : null;
      // print("Scanned CODE : $_scanCode");
      _isScanning = false;
    });
  }

  @override
  QrScreenBloc getBloc() => _bloc;

  void connectWifi() {
    String ssidValue = 'estontest';
    String passwordValue = "estontest";
    String ipaddressValue = '192.168.1.104';
    String gatewayValue = '192.168.1.1';
    String subnetValue = '255.255.255.0';
    connect(ssidValue, passwordValue, ipaddressValue, gatewayValue, subnetValue,
        context);
  }

  Future<void> connect(String ssid, String password, String ipaddress,
      String gateway, String subnet, BuildContext context) async {
    final String ssidValue = ssid;
    final String passwordValue = password;

    // Remove . from ipaddress, gateway, and subnet
    String ipaddressValue = ipaddress.replaceAll('.', '');
    String gatewayValue = gateway.replaceAll('.', '');
    String subnetValue = subnet.replaceAll('.', '');

    //get third part of ip address from ipaddress distinguse with.
    String ipaddressValue3 = ipaddress.split('.')[2];
    //count lnth part of ip address
    int ipaddressValue3length = ipaddressValue3.length;

    //get fourth part of gateway from gateway distinguse with .
    String gatewayValue4 = gateway.split('.')[3];
    //count lnth part of gateway
    int gatewayValue4length = gatewayValue4.length;

    // print values
    print("SSID: " + ssidValue);
    print("Password: " + passwordValue);
    print("IP Address: " + ipaddressValue);
    print("Gateway: " + gatewayValue);
    print("Subnet: " + subnetValue);

    print("IP Address 3rd part: " + ipaddressValue3);
    print("Gateway 4th part: " + gatewayValue4);

    print("IP Address 3rd part length: " + ipaddressValue3length.toString());
    print("Gateway 4th part ength: " + gatewayValue4length.toString());

    final String url =
        'http://192.168.4.1:80/*,WIFISSID=$ssidValue,WIFIPWD=$passwordValue,lip=$ipaddressValue,gatway=$gatewayValue,sbnet=$subnetValue,lip3_d=$ipaddressValue3length,gway4_d=$gatewayValue4length';

    try {
      final response = await http.get(Uri.parse(url));
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        print("Response Body: ${response.body}");
        // Process the response data
      } else {
        print("Error Occurred! Status Code: ${response.statusCode}");
      }
    } catch (ex) {
      print(ex.toString());
    }
  }
}


