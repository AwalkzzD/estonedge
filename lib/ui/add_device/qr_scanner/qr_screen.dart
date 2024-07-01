import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/data/remote/model/qr_code/qr_scan_response.dart';
import 'package:estonedge/ui/add_device/macid/macid_screen.dart';
import 'package:estonedge/ui/add_device/qr_scanner/qr_screen_bloc.dart';
import 'package:estonedge/utils/wifi_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:mqtt_client/mqtt_server_client.dart';

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

      showMessageBar('Turn on device Wifi to continue');

      connectSmartDevice(qrScanResponse);
    } catch (ex) {
      print(ex.toString());
      showMessageBar('Invalid QR Code\nScan QR given on the board');
    }
  }

  @override
  QrScreenBloc getBloc() => _bloc;



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
    Future.delayed(const Duration(seconds: 2), () {
      showMessageBar('Searching smart device wifi connection');
    });
    await WifiUtils.init();

    WifiUtils.disconnectWifi();

    await WifiUtils.connectWifiByName(qrScanResponse.ssid!,
            password: qrScanResponse.password!)
        .then((connectionResult) {
      if (connectionResult) {
        Navigator.push(context, MacidScreen.route());
      } else {
        showMessageBar(
            'Something went wrong!\nTry contacting Eston Automation for help');
      }
    });
  }
}
