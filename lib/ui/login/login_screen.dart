import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_textfield.dart';
import 'package:estonedge/generated/assets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildCustomAppBar(),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 26),
        child: const Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                'SIGN IN',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RubikMedium-DRPE',
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              'Looks like you don’t have an account. Let’s create a new account for you.',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Rubik-W92V',
                //fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 30),
            CustomTextfield(
              hintText: 'Email',
              icon: Icon(Icons.email),
            ),
            SizedBox(height: 20),
            CustomTextfield(
              hintText: 'Password',
              icon: Icon(Icons.lock),
            ),
            SizedBox(height: 20),
            CustomButton(btnText: 'LOGIN')
          ],
        ),
      ),
    );
  }

  Widget buildCustomAppBar() {
    /// Row widget to create a custom appbar
    return Padding(
      padding: const EdgeInsets.only(right: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            children: [
              Image.asset(Assets.iconsAppLogo),
              const SizedBox(width: 12),
              const Text(
                'EstonEdge',
                style: TextStyle(
                    fontSize: 34,
                    fontFamily: 'RubikMedium-DRPE',
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
