import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_textfield.dart';
import 'package:estonedge/data/remote/auth/auth_repository.dart';
import 'package:estonedge/ui/auth/utils/custom_app_bar.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController nameInputController = TextEditingController();
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const CustomAppBar(),
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
            CustomTextField(
              hintText: 'Name',
              icon: const Icon(Icons.person),
              isPassword: false,
              controller: nameInputController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: 'Email',
              icon: const Icon(Icons.email),
              isPassword: false,
              controller: emailInputController,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: 'Password',
              icon: const Icon(Icons.lock),
              isPassword: true,
              controller: passwordInputController,
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
                signOut();
                /*initiateSignUp(
                  name: nameInputController.text,
                  email: emailInputController.text,
                  password: passwordInputController.text,
                );*/
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initiateSignUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final sendVerificationCode = await AuthRepository()
        .initiateSignUp(email: email, password: password, name: name);

    if (sendVerificationCode != null && sendVerificationCode == true) {
      showOtpDialog(email: email);
    }
  }

  Future<void> completeSignUp({
    required String email,
    required String verificationCode,
  }) async {
    final isSignUpComplete = await AuthRepository()
        .completeSignUp(email: email, verificationCode: verificationCode);
  }

  void showOtpDialog({required String email}) {
    TextEditingController otpController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Enter 6-digit OTP',
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Rubik-W92V',
                fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: otpController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            decoration: const InputDecoration(
              hintText: 'OTP',
              hintStyle: TextStyle(
                fontSize: 14,
                fontFamily: 'Rubik-W92V',
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Submit',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Rubik-W92V',
                  //fontWeight: FontWeight.bold
                ),
              ),
              onPressed: () async {
                completeSignUp(
                    email: email, verificationCode: otpController.text);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void navigateToHome() => Navigator.pushReplacementNamed(context, '/home');

  void signOut() async => await Amplify.Auth.signOut();
}
