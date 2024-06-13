import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/screens/base_widget.dart';
import 'package:estonedge/data/remote/repository/auth/auth_repository_provider.dart';
import 'package:flutter/material.dart';

class SplashScreen extends BaseWidget {
  const SplashScreen({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _SplashScreenState();
}

class _SplashScreenState extends BaseWidgetState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );

  @override
  void initState() {
    super.initState();
    _controller.forward();
    navigateToHomeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: Tween<double>(begin: 1.0, end: 0.0).animate(_animation),
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: Image.asset(AppImages.splashImage),
          ),
        ),
      ),
    );
  }

  Future<void> navigateToHomeScreen() async {
    final isUserSessionActive = await ref.read(userSessionProvider);
    await Future.delayed(const Duration(seconds: 2), () {
      isUserSessionActive
          ? Navigator.pushReplacementNamed(context, '/signup')
          : Navigator.pushReplacementNamed(context, '/signup');
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
