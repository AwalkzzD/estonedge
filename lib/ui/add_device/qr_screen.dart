import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/screens/base_widget.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class QrScreen extends BaseWidget {
  const QrScreen({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _QrScreenState();
}

class _QrScreenState extends BaseWidgetState<QrScreen> {
  String? _scanCode;
  bool _isFlashOn = false;
  bool _isScanning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Center(
            child: Text(
          'Scan QR Code',
          style: TextStyle(color: Colors.white),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
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
              onPressed: () {},
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
}
