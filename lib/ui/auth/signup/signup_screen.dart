import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_textfield.dart';
import 'package:estonedge/ui/auth/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomAppBar(),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 16.0, right: 16.0, top: 26),
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                'SIGN UP',
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
              hintText: 'Name',
              icon: Icon(Icons.person),
              isPassword: false,
            ),
            const SizedBox(height: 20),
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
            RichText(
              text: const TextSpan(
                text: 'By selecting Create Account below, I agree to ',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Rubik-W92V',
                  color: Colors.black87, // Set the default text color
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Terms of Service',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Bold
                    ),
                  ),
                  TextSpan(
                    text: ' & ',
                  ),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Bold
                    ),
                  ),
                  TextSpan(
                    text: '.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              btnText: 'CREATE ACCOUNT',
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
          ],
        ),
      ),
    );
  }
}
