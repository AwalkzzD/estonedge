import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:estonedge/amplifyconfiguration.dart';
import 'package:estonedge/base/src_components.dart';
import 'package:estonedge/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'app_bloc.dart';
import 'base/bloc/base_bloc_provider.dart';
import 'base/constants/app_widgets.dart';
import 'base/src_utils.dart';
import 'base/theme/app_theme.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await SpUtil.getInstance();
    await _configureAmplify();
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    runApp(
      BlocProvider<AppBloc>(
          initBloc: AppBloc(),
          child: BlocProvider<AppTheme>(
            initBloc: AppTheme(),
            child: const MainApp(),
          )),
    );
    // ru nApp(const ProviderScope(child: MainApp()));
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

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return ScreenUtilInit(
      builder: () => MaterialApp(
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
          navigatorKey: navigatorKey,
          title: "EstonEdge"),
    );
  }
}
