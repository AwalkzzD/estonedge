import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/ui/profile/profile_details_screen.dart';
import 'package:estonedge/ui/profile/profile_screen_bloc.dart';
import 'package:estonedge/utils/shared_pref.dart';
import 'package:flutter/material.dart';

import '../../base/src_widgets.dart';

class ProfileScreen extends BasePage {
  const ProfileScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _ProfileScreenState();

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const ProfileScreen());
  }
}

class _ProfileScreenState
    extends BasePageState<ProfileScreen, ProfileScreenBloc> {
  final ProfileScreenBloc _bloc = ProfileScreenBloc();

  @override
  Widget buildWidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.account_circle,
            ),
            iconSize: 130,
          ),
          Text(getUserName(), style: fs20BlackSemibold),
          Text(
            getUserEmail(),
            style: fs14BlackRegular,
          ),
          const SizedBox(height: 50),
          profileButtons(const Icon(Icons.account_circle), 'More Info', () {
            Navigator.push(context, ProfileDetailsScreen.route());
          }),
          const SizedBox(height: 20),
          profileButtons(const Icon(Icons.support), 'Privacy Policy', () {}),
          const SizedBox(height: 20),
          profileButtons(const Icon(Icons.logout), 'Logout', () {}),
        ],
      ),
    );
  }

  @override
  ProfileScreenBloc getBloc() => _bloc;
}

Widget profileButtons(Icon prefixIcon, String btnText, Function() onPressed) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
    child: Row(
      children: [
        Icon(prefixIcon.icon, color: Colors.black),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            btnText,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontFamily: 'Lexend', fontSize: 16, color: Colors.black),
          ),
        ),
        const Icon(Icons.chevron_right_sharp, color: Colors.black),
      ],
    ),
  );
}
