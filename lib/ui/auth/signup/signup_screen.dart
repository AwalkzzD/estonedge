import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_textfield.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/ui/auth/signup/signup_screen_bloc.dart';
import 'package:estonedge/ui/auth/utils/custom_auth_app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../validators.dart';

class SignupScreen extends BasePage {
  const SignupScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _SignupScreenState();

        static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const SignupScreen());
  }
}

class _SignupScreenState extends BasePageState<SignupScreen, SignupScreenBloc> {
  final SignupScreenBloc _bloc = SignupScreenBloc();

  final TextEditingController nameInputController = TextEditingController();
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();
  final TextEditingController verificationCodeController =
      TextEditingController();

  bool isLoading = false;

  String? nameError;
  String? emailError;
  String? passwordError;

  @override
  void dispose() {
    nameInputController.dispose();
    emailInputController.dispose();
    passwordInputController.dispose();
    verificationCodeController.dispose();
    super.dispose();
  }

  @override
  Widget? getAppBar() {
    return AppBar(
      backgroundColor: white,
      automaticallyImplyLeading: false,
      title: const CustomAppBar(),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 26),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                'SIGN UP',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              'Looks like you don’t have an account. Let’s create a new account for you.',
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Lexend',
                //fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 30),
            CustomTextField(
              hintText: 'Name',
              icon: const Icon(Icons.person),
              isPassword: false,
              controller: nameInputController,
              errorText: nameError,
              onChanged: (text) {
                setState(() {
                  nameError = validateName(text);
                });
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: 'Email',
              icon: const Icon(Icons.email),
              isPassword: false,
              controller: emailInputController,
              errorText: emailError,
              onChanged: (text) {
                setState(() {
                  emailError = validateEmail(text);
                });
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hintText: 'Password',
              icon: const Icon(Icons.lock),
              isPassword: true,
              controller: passwordInputController,
              errorText: passwordError,
              onChanged: (text) {
                setState(() {
                  passwordError = validatePassword(text);
                });
              },
            ),
            const SizedBox(height: 20),
            RichText(
              text: const TextSpan(
                text: 'By selecting Create Account below, I agree to ',
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Lexend',
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
                setState(() {
                  nameError = validateName(nameInputController.text);
                  emailError = validateEmail(emailInputController.text);
                  passwordError =
                      validatePassword(passwordInputController.text);
                });

                if (nameError == null &&
                    emailError == null &&
                    passwordError == null) {
                  getBloc().attemptSignUp(
                      emailInputController.text,
                      passwordInputController.text,
                      nameInputController.text, (response) {
                    if (response.nextStep.signUpStep ==
                        AuthSignUpStep.confirmSignUp) {
                      showMessageBar('OTP sent to your email');
                      verifyEmail(email: emailInputController.text);
                    }
                  }, (errorMsg) {
                    showMessageBar(errorMsg);
                  });
                }
              },
              width: double.infinity,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () => navigateToLoginScreen(),
                text: 'Already a user?',
                style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lexend',
                    color: Colors.blueAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  SignupScreenBloc getBloc() => _bloc;

  void verifyEmail({required String email}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          title: const Text(
            'Enter 6-digit OTP',
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: verificationCodeController,
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
              onPressed: () {
                if (verificationCodeController.text.length == 6) {
                  getBloc().attemptUserSignUpVerification(
                      email, verificationCodeController.text, (response) {
                    if (response.isSignUpComplete &&
                        response.nextStep.signUpStep == AuthSignUpStep.done) {
                      showMessageBar('Login to continue');
                      navigateToLoginScreen();
                    }
                  }, (errorMsg) {
                    showMessageBar(errorMsg);
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  bool customBackPressed() => true;

  @override
  void onBackPressed(bool didPop, BuildContext context) {
    if (!didPop) {
      if (isDrawerOpen()) {
        closeDrawer();
      } else {
        hideSoftInput();
        SystemNavigator.pop();
      }
    }
  }

  void navigateToLoginScreen() =>
      Navigator.pushReplacementNamed(context, '/login');
}
