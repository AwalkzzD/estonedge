import 'package:estonedge/base/screens/base_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends BaseWidget {
  const ProfileScreen({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseWidgetState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
            const Text(
              'Ruben Gedit',
              style: TextStyle(
                  fontFamily: 'Lexend',
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            const Text(
              'ruben.geidt@example.com',
              style: TextStyle(fontFamily: 'Lexend', fontSize: 14),
            ),
            const SizedBox(height: 20),
            profileButtons(const Icon(Icons.account_circle), 'Profile Details',
                () {
              Navigator.pushNamed(context, '/profileDetails');
            }),
            const SizedBox(height: 20),
            profileButtons(const Icon(Icons.support),
                'Terms and Service/Privacy Policy', () {}),
            const SizedBox(height: 20),
            profileButtons(const Icon(Icons.logout), 'Logout', () {}),
          ],
        ),
      ),
    );
  }
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
      mainAxisSize: MainAxisSize.max,
      children: [
        Icon(prefixIcon.icon, color: Colors.black),
        const SizedBox(width: 10),
        Text(
          btnText,
          style: const TextStyle(
              fontFamily: 'Lexend', fontSize: 16, color: Colors.black),
        ),
        const Spacer(),
        const Icon(Icons.chevron_right_sharp, color: Colors.black),
      ],
    ),
  );
}
