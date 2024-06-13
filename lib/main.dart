import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:estonedge/amplifyconfiguration.dart';
import 'package:estonedge/base/src_components.dart';
import 'package:estonedge/ui/auth/login/login_screen.dart';
import 'package:estonedge/ui/auth/signup/signup_screen.dart';
import 'package:estonedge/ui/home/home_screen.dart';
import 'package:estonedge/ui/home/room/add_room/add_room_screen.dart';
import 'package:estonedge/ui/home/room/add_room/room_image_screen.dart';
import 'package:estonedge/ui/introduction/get_started.dart';
import 'package:estonedge/ui/splash/splash_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'base/constants/app_widgets.dart';
import 'base/src_utils.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    GestureBinding.instance.resamplingEnabled = true;
    await _configureAmplify();

    /// Shared Preferences
    await SpUtil.getInstance();
    runApp(const ProviderScope(child: MainApp()));
  } on AmplifyException catch (e) {
    runApp(Text("Something went wrong: ${e.message}"));
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

Future<void> _configureAmplify() async {
  try {
    await Amplify.addPlugin(AmplifyAuthCognito());
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    safePrint('Error configuring Amplify: $e');
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return OTS(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/introduction': (context) => const GetStarted(),
          '/home': (context) => const HomeScreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
        '/addRoom': (context) => const AddRoomScreen(),
        '/selectRoomImage': (context) => const SelectRoomImageScreen()
        },
      ),
    );
  }
}
