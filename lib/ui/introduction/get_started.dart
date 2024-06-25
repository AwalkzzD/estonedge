import '../../../base/src_bloc.dart';
import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/ui/auth/login/login_screen.dart';
import 'package:estonedge/ui/introduction/get_started_bloc.dart';
import 'package:flutter/material.dart';

class GetStarted extends BasePage {
  const GetStarted({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _GetStartedState();

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const GetStarted());
  }
}

class _GetStartedState extends BasePageState<GetStarted, GetStartedBloc> {
  final GetStartedBloc _bloc = GetStartedBloc();

  @override
  GetStartedBloc getBloc() => _bloc;

  @override
  Widget buildWidget(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(AppImages.getStartedHomeIllutstration),
          const Padding(
            padding: EdgeInsets.all(15.0),
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
              Navigator.pushReplacement(context, LoginScreen.route());
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
            child: const Padding(
              padding: EdgeInsets.all(15.0),
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
    );
  }
}
