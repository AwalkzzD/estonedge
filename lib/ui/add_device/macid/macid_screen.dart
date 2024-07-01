import 'package:estonedge/base/constants/app_styles.dart';
import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_textfield.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/ui/add_device/macid/macid_screen_bloc.dart';
import 'package:http/http.dart' as http;
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
  final MacidScreenBloc _bloc = MacidScreenBloc();
  final TextEditingController ssidController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? ssidError;

  @override
  void dispose() {
    ssidController.dispose();
    super.dispose();
  }

  @override
  Widget? getAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'MacID Details',
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
          'Enter Wi-Fi credential of the device',
          style: fs18BlueSemiBold,
        ),
        const SizedBox(height: 40),
        CustomTextFieldWiFi(
          labelText: 'MacID/SSID',
          hintText: 'Enter MacID/SSID',
          controller: ssidController,
          errorText: ssidError,
          /*onChanged: (text) {
            setState(() {
              ssidError = validateSSID(text);
            });
          },*/
        ),
        const SizedBox(height: 40),
        CustomTextFieldWiFi(
          controller: passwordController,
          labelText: 'Password',
          hintText: 'Enter your password',
        ),
        const SizedBox(height: 70),
        CustomButton(
            btnText: 'Submit',
            color: Colors.blue,
            onPressed: () {
              connectWifi(ssidController.text, passwordController.text);
            })
      ]),
    );
  }

  void connectWifi(String ssid, String password) {
    // connectMqtt();

    String ssidValue = ssid;
    String passwordValue = password;
    String ipaddressValue = '192.168.4.8';
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

  @override
  MacidScreenBloc getBloc() => _bloc;
}
