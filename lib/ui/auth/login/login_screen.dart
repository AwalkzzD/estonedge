import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_textfield.dart';
import 'package:estonedge/ui/auth/utils/custom_app_bar.dart';
import 'package:flutter/gestures.dart';
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
        title: const CustomAppBar(),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
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
            const Text(
              'Looks like you don’t have an account. Let’s create a new account for you.',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Rubik-W92V',
                //fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 30),
            const CustomTextField(
              hintText: 'Email',
              icon: Icon(Icons.email),
              isPassword: false,
            ),
            const SizedBox(height: 20),
            const CustomTextField(
              hintText: 'Password',
              icon: Icon(Icons.lock),
              isPassword: true,
            ),
            const SizedBox(height: 20),
            CustomButton(
              btnText: 'LOGIN',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                text: "Don't have an account? ",
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'Rubik-W92V',
                ),
                children: <TextSpan>[
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => navigateToSignUpScreen(),
                    text: 'Sign Up',
                    style: const TextStyle(color: Colors.blueAccent),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToSignUpScreen() {
    Navigator.pushNamed(context, '/signup');
  }
}
