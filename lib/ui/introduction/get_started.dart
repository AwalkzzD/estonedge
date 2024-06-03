import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/screens/base_widget.dart';
import 'package:flutter/material.dart';

class GetStarted extends BaseWidget {
  const GetStarted({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _GetStartedState();
}

class _GetStartedState extends BaseWidgetState<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image.asset(AppImages.getStartedHomeIllutstration),
            const Padding(
              padding:  EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Easily Control Your Home',
                    style: TextStyle(
                        height: 1.2,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Manage your home from anytime, anywhere.',
                    style: TextStyle(
                        color: Color.fromRGBO(112, 121, 126, 1),
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0))),
              child: const Padding(
                padding:  EdgeInsets.all(15.0),
                child: Text(
                  'GET STARTED',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.normal,
                      fontSize: 16),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
