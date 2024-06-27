import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/ui/auth/login/login_screen.dart';
import 'package:estonedge/ui/home/home_screen.dart';
import 'package:estonedge/ui/introduction/get_started.dart';
import 'package:estonedge/ui/splash/splash_screen_bloc.dart';
import 'package:flutter/material.dart';

class SplashScreen extends BasePage {
  const SplashScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _SplashScreenState();
}

class _SplashScreenState extends BasePageState<SplashScreen, SplashScreenBloc>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );

  final SplashScreenBloc _bloc = SplashScreenBloc();

  @override
  void initState() {
    super.initState();
    _controller.forward();
    navigateToHomeScreen();
  }

  void navigateToHomeScreen() async {
    getBloc().checkUserSession((isActive) async {
      if (isActive) {
        await Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(context, HomeScreen.route());
          // Navigator.pushReplacementNamed(context, '/home');
        });
      } else {
        await Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(context, LoginScreen.route());
          // Navigator.pushReplacementNamed(context, '/login');
        });
      }
    }, (errorMsg) async {
      await Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(context, GetStarted.route());
        // Navigator.pushReplacementNamed(context, '/login');
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget buildWidget(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: Tween<double>(begin: 1.0, end: 0.0).animate(_animation),
        child: Padding(
          padding: const EdgeInsets.all(7.0),
          child: Image.asset(AppImages.splashImage),
        ),
      ),
    );
  }

  @override
  SplashScreenBloc getBloc() => _bloc;
}
