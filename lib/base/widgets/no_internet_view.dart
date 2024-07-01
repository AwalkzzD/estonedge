import 'package:estonedge/base/constants/app_images.dart';
import 'package:estonedge/base/constants/app_styles.dart';
import 'package:flutter/material.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImages.noInternet),
          const Text(
            'Whoops!',
            style: fs24BlackSemibold,
          ),
          const Text(
            ' Something went wrong. Check your ',
            style: fs16BlackRegular,
          ),
          const Text(
            'connection or try again.',
            style: fs16BlackRegular,
          )
        ],
      ),
    );
  }

}