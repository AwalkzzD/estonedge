import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:estonedge/amplifyconfiguration.dart';
import 'package:estonedge/base/src_components.dart';
import 'package:estonedge/ui/add_device/add_your_device_screen.dart';
import 'package:estonedge/ui/add_device/macid_screen.dart';
import 'package:estonedge/ui/add_device/qr_screen.dart';
import 'package:estonedge/ui/add_device/wifi_screen.dart';
import 'package:estonedge/ui/auth/login/login_screen.dart';
import 'package:estonedge/ui/auth/signup/signup_screen.dart';
import 'package:estonedge/ui/home/home_screen.dart';
import 'package:estonedge/ui/home/room/add_room/add_room_screen.dart';
import 'package:estonedge/ui/home/room/add_room/room_image_screen.dart';
import 'package:estonedge/ui/home/room/add_room/room_list_provider.dart';
import 'package:estonedge/ui/home/room/room_screen.dart';
import 'package:estonedge/ui/home/room/board/add_board_screen.dart';
import 'package:estonedge/ui/home/room/board/board_details_screen.dart';
import 'package:estonedge/ui/home/room/room_details/room_details_screen.dart';
import 'package:estonedge/ui/home/room/switch/switch_details_screen.dart';
import 'package:estonedge/ui/home/scheduler/schedule_home_screen.dart';
import 'package:estonedge/ui/home_test/home_screen_test.dart';
import 'package:estonedge/ui/introduction/get_started.dart';
import 'package:estonedge/ui/profile/profile_details_screen.dart';
import 'package:estonedge/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base/constants/app_widgets.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    final sharedPreferences = await SharedPreferences.getInstance();
    await _configureAmplify();
    runApp(ProviderScope(overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ], child: MainApp()));
  } on AmplifyException catch (e) {
    runApp(Text("Something went wrong: ${e.message}"));
  }
}

Future<void> _configureAmplify() async {
  try {
    await Amplify.addPlugin(AmplifyAuthCognito());
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    safePrint('Error configuring Amplify: $e');
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ScreenUtilInit(
      builder: () => MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => const SplashScreen(),
            '/introduction': (context) => const GetStarted(),
            '/home': (context) => const HomeScreen(),
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignupScreen(),
            '/addRoom': (context) => const AddRoomScreen(),
            '/room': (context) => const RoomScreen(),
            '/selectRoomImage': (context) => const SelectRoomImageScreen(),
            '/homeScreenTest': (context) => const HomeScreenTest(),
            '/scheduleHome': (context) => const ScheduleHomeScreen(),

            '/addDevice': (context) => AddDeviceScreen(), 
            '/qrScanner': (context) => const QrScreen(),
            '/macIdScreen': (context) => const MacidScreen(),
            '/wifiScreen': (context) => const WifiScreen(),

            '/profileDetails': (context) => const ProfileDetailsScreen(),
            '/roomDetails': (context) => const RoomDetailsScreen(
                  roomName: '',
                  roomImage: '',
                ),
            '/addBoard': (context) => const AddBoardScreen(),
            '/boardDetails': (context) => BoardDetailsScreen(),
            '/switchDetails': (context) => SwitchDetailsScreen(),
          },
          debugShowCheckedModeBanner: false,
          title: "EstonEdge"),
    );
  }
}
