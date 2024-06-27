import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/src_widgets.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const ImageView(
                image: AppImages.getStartedHomeIllutstration,
                imageType: ImageType.svg),
            const Column(
              children: <Widget>[
                Text('Easily Control', style: fs32BlackSemiBold),
                Text('Your Home', style: fs32BlackSemiBold),
                SizedBox(height: 20),
                Text('Welcome to a new era of home automation,',
                    style: fs15BlackRegular),
                Text('where comfort, security, and efficiency are just',
                    style: fs15BlackRegular),
                Text('a tap away.', style: fs15BlackRegular),
              ],
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
                  style: fs16WhiteRegular,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
