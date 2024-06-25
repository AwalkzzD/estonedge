import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/constants/app_styles.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/ui/add_device/add_your_device_screen_bloc.dart';
import 'package:estonedge/ui/add_device/macid/macid_screen.dart';
import 'package:estonedge/ui/add_device/qr_scanner/qr_screen.dart';
import 'package:estonedge/ui/add_device/widgets/device_options_card.dart';
import 'package:flutter/material.dart';

class AddDeviceScreen extends BasePage {
  const AddDeviceScreen({super.key});

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const AddDeviceScreen());
  }

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() => _AddDeviceScreenState();
}

class _AddDeviceScreenState extends BasePageState<AddDeviceScreen, AddYourDeviceScreenBloc> {

  final AddYourDeviceScreenBloc _bloc = AddYourDeviceScreenBloc();

  @override
  Widget? getAppBar() {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: const Text('Add your devices', style: fs24BlackBold),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          DeviceOptionCard(
            icon: AppImages.addDeviceQR,
            title: 'Scan QR Code',
            subtitle: 'Scan the QR code to add smart device',
            onTap: () {
              Navigator.push(context, QrScreen.route());
            },
          ),
          const SizedBox(height: 20),
          DeviceOptionCard(
            icon: AppImages.addDeviceManually,
            title: 'Enter manually',
            subtitle: 'Enter Mac ID of smart device',
            onTap: () {
              // Navigator.pushNamed(context, '/macIdScreen');
              Navigator.push(context, MacidScreen.route());
            },
          ),
        ],
      ),
    );
  }

  @override
  AddYourDeviceScreenBloc getBloc() => _bloc;
}
