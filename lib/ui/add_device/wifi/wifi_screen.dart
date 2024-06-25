import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/constants/app_styles.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_textfield.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/ui/add_device/wifi/wifi_screen_bloc.dart';
import 'package:estonedge/utils/validators.dart';
import 'package:flutter/material.dart';

class WifiScreen extends BasePage {
  const WifiScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _WifiScreenState();

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const WifiScreen());
  }
}

class _WifiScreenState extends BasePageState<WifiScreen, WifiScreenBloc> {
  final WifiScreenBloc _bloc = WifiScreenBloc();
  final TextEditingController wifiController = TextEditingController();

  String? wifiError;

  @override
  void dispose() {
    wifiController.dispose();
    super.dispose();
  }

  @override
  Widget? getAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'WiFi Details',
        style: fs24BlackBold,
      ),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(children: [
        const SizedBox(height: 20),
        Text(
          'Enter your personal Wi-Fi credential to connect with smart device',
          style: fs18BlueSemiBold,
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
            })
      ]),
    );
  }

  @override
  WifiScreenBloc getBloc() => _bloc;
}
