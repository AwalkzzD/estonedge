import 'package:estonedge/base/screens/base_widget.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_textfield.dart';
import 'package:estonedge/ui/auth/validators.dart';
import 'package:flutter/material.dart';

class WifiScreen extends BaseWidget {
  const WifiScreen({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _WifiScreenState();
}

class _WifiScreenState extends BaseWidgetState<WifiScreen> {
  final TextEditingController wifiController = TextEditingController();

  String? wifiError;

  @override
  void dispose() {
    wifiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'WiFi Details',
              style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 24,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [
            const SizedBox(height: 20),
            const Text(
              'Enter your personal Wi-Fi credential to connect with smart device',
              style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue),
            ),
            const SizedBox(height: 40),
            CustomTextfieldWiFi(
              labelText: 'Wi-Fi',
              hintText: 'Enter your WiFi name',
              controller: wifiController,
              errorText: wifiError,
              onChanged: (text) {
                setState(() {
                  wifiError = validateSSID(text);
                });
              },
            ),
            const SizedBox(height: 40),
            const CustomTextfieldWiFi(
              labelText: 'Password',
              hintText: 'Enter your password',
            ),
            const SizedBox(height: 70),
            CustomButton(
                btnText: 'Submit',
                width: 145.0,
                color: Colors.blue,
                onPressed: () {
                  setState(() {
                    wifiError = validateSSID(wifiController.text);
                  });
                  if (wifiError == null) {
                    print('OK');
                  }
                })
          ]),
        ));
  }
}
