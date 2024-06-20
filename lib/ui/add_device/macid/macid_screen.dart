import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/screens/base_widget.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_textfield.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/ui/add_device/macid/macid_screen_bloc.dart';
import 'package:estonedge/ui/auth/validators.dart';
import 'package:flutter/material.dart';

class MacidScreen extends BasePage {
  const MacidScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _MacidScreenState();

      static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const MacidScreen());
  }
}

class _MacidScreenState extends BasePageState<MacidScreen, MacidScreenBloc> {
  MacidScreenBloc _bloc = MacidScreenBloc();
  final TextEditingController ssidController = TextEditingController();

  String? ssidError;

  @override
  void dispose() {
    ssidController.dispose();
    super.dispose();
  }

  @override
  Widget? getAppBar() {
    return AppBar(
      title: const Center(
        child: Text(
          'MacID Details',
          style: TextStyle(
              fontFamily: 'Lexend', fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(children: [
        const SizedBox(height: 20),
        const Text(
          'Enter Wi-Fi credential of the device',
          style: TextStyle(
              fontFamily: 'Lexend',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.blue),
        ),
        const SizedBox(height: 40),
        CustomTextfieldWiFi(
          labelText: 'MacID/SSID',
          hintText: 'Enter MacID/SSID',
          controller: ssidController,
          errorText: ssidError,
          onChanged: (text) {
            setState(() {
              ssidError = validateSSID(text);
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
                ssidError = validateSSID(ssidController.text);
              });
              if (ssidError == null) {
                print('OK');
              }
            })
      ]),
    );
  }

  @override
  MacidScreenBloc getBloc() => _bloc;
}
