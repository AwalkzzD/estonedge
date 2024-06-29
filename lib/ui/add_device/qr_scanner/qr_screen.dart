import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/data/remote/model/qr_code/qr_scan_response.dart';
import 'package:estonedge/ui/add_device/qr_scanner/qr_screen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:wifi_iot/wifi_iot.dart';

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

  late MqttServerClient client;
  String statusText = 'Disconnected';
  String broker = 'a17a02pgdgc41-ats.iot.us-east-2.amazonaws.com';
  int port = 8883;
  String clientIdentifier = 'iotconsole-16456e21-0605-417a-9cbc-33e4a22c47ee';
  String topic = 'esp32/pub';

  String? _scanCode;
  bool _isFlashOn = false;
  bool _isScanning = false;

  @override
  void initState() {
    // connectMqtt();
    super.initState();
  }

  @override
  Widget? getAppBar() {
    return AppBar(
      backgroundColor: Colors.blue.shade300,
      leading: Builder(
        builder: (context) {
          return IconButton(
            icon: Image.asset(
              AppImages.appBarBackIcon,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          );
        },
      ),
      centerTitle: true,
      title: const Text(
        'Scan QR Code',
        style: fs24WhiteSemibold,
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
            const Text(
              'Scan QR Code of the smart device',
              style: fs18WhiteSemiBold,
              textAlign: TextAlign.center,
            ),
            Center(child: Image.asset(AppImages.qrCode)),
            const Text(
                'The QR Code will be automatically detected when you position it between the guide lines',
                style: fs14WhiteMedium,
                textAlign: TextAlign.center),
            const SizedBox(height: 50),
            CustomButton(
                btnText: 'Link',
                color: white,
                onPressed: () => scanQR(),
                // onPressed: () => connectWifi(),
                textColor: Colors.blueAccent),
          ],
        ),
      ),
      /*body: Padding(
        padding: const EdgeInsets.fromLTRB(15.0, 115.0, 15.0, 15.0),
        child: Column(
          children: [
            const Text(
              'Scan QR Code of the smart device',
              style: fs18WhiteSemiBold,
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Center(child: Image.asset(AppImages.qrCode)),
            ),
            const Text(
              'The QR Code will be automatically detected when you position it between the guide lines',
              style: fs14WhiteMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            CustomButton(
                btnText: 'Link',
                color: white,
                // onPressed: () => scanQR(),
                onPressed: () {}, //connectWifi(),
                textColor: Colors.blueAccent),
          ],
        ),
      ),*/
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

    try {
      final QrScanResponse qrScanResponse =
          qrScanResponseFromJson(barcodeScanRes != '-1' ? barcodeScanRes : "");

      showMessageBar('Connecting to your smart device');

      connectSmartDevice(qrScanResponse);
    } catch (ex) {
      print(ex.toString());
      showMessageBar('Invalid QR Code\nScan QR given on the board');
    }
  }

  @override
  QrScreenBloc getBloc() => _bloc;

  void connectWifi() {
    // connectMqtt();

    String ssidValue = 'Aorus';
    String passwordValue = "Nexo_swara";
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

  /*Future<void> connectMqtt() async {
    client = MqttServerClient.withPort(broker, clientIdentifier, port);
    client.secure = true;
    client.keepAlivePeriod = 200;
    client.autoReconnect = true;
    client.logging(on: true);

    // Set security context for TLS/SSL
    final context = SecurityContext.defaultContext;

    ByteData trustedCertificateBytes = await rootBundle.load(Assets.awsKeysCa1);
    context.setTrustedCertificatesBytes(
        trustedCertificateBytes.buffer.asUint8List());

    ByteData certificateChainBytes =
        await rootBundle.load(Assets.awsKeysDeviceCert);
    context
        .useCertificateChainBytes(certificateChainBytes.buffer.asUint8List());

    ByteData privateKeyBytes = await rootBundle.load(Assets.awsKeysPrivate);
    context.usePrivateKeyBytes(privateKeyBytes.buffer.asUint8List());

    client.logging(on: true);

    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;

    try {
      await client.connect();
    } catch (e) {
      print('Exception: $e');
      disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client connected to AWS IoT');

      // Print incoming messages from another client on this topic
      client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final recMess = c[0].payload as MqttPublishMessage;
        final pt =
            MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
        print(
            'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
        print('');
      });
    } else {
      print(
          'ERROR MQTT client connection failed - disconnecting, state is ${client.connectionStatus!.state}');
      client.disconnect();
    }
  }

  void onConnected() {
    setState(() {
      statusText = 'Connected';
    });
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  void onDisconnected() {
    setState(() {
      statusText = 'Disconnected';
    });
  }

  void onSubscribed(String topic) {
    setState(() {
      statusText = 'Subscribed to $topic';
    });
  }

  void onSubscribeFail(String topic) {
    setState(() {
      statusText = 'Failed to subscribe $topic';
    });
  }

  void pong() {
    print(
        '---------------------------------------------------------------------------------------------------------------------------------');
    setState(() {
      statusText = 'Ping response received';
    });
  }

  void disconnect() {
    client.disconnect();
  }*/

  Future<void> connectSmartDevice(QrScanResponse qrScanResponse) async {
    /*final result = await WiFiForIoTPlugin.findAndConnect(
        qrScanResponse.ssid ?? "",
        password: qrScanResponse.password);*/

    try {
      final connectionResult = await WiFiForIoTPlugin.registerWifiNetwork(
          qrScanResponse.ssid ?? "",
          bssid: qrScanResponse.ssid ?? "",
          password: qrScanResponse.password,
          security: NetworkSecurity.WPA);

      print('Connection Result Repsonse -----> $connectionResult');

      showMessageBar("Smart Board Connected");
    } catch (ex) {
      print(ex.toString());
      showMessageBar("Unable to connect!\nTry enabling your device Wifi");
    }
  }
}
