import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/screens/base_widget.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/ui/add_device/qr_scanner/qr_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
      title: const Center(
        child: Text(
          'Scan QR Code',
          style: TextStyle(color: Colors.white),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            _isFlashOn ? Icons.flash_on : Icons.flash_off,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _isFlashOn = !_isFlashOn;
              // Handle flash toggle
            });
          },
        )
      ],
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              'Scan QR Code of the smart device',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Lexend',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            Center(child: Image.asset(AppImages.qrCode)),
            const Text(
              'The QR Code will be automatically detected when you position it between the guide lines',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            OutlinedButton(
              onPressed: () {
                scanQR();
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue.shade300,
                backgroundColor: Colors.white,
                side: BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Less rounded border
                ),
                minimumSize: Size(145, 40), // More width
              ),
              child: Text('Link'),
            ),
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
        _isFlashOn,
        ScanMode.QR,
      );
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanCode = barcodeScanRes != '-1' ? barcodeScanRes : null;
      print("Scanned CODE : $_scanCode");
      _isScanning = false;
    });
  }

  @override
  QrScreenBloc getBloc() => _bloc;
}
