import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_components.dart';
import 'package:estonedge/base/src_constants.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_textfield.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/ui/auth/login/login_screen.dart';
import 'package:estonedge/ui/auth/signup/signup_screen_bloc.dart';
import 'package:estonedge/ui/auth/utils/custom_auth_app_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../base/src_widgets.dart';
import '../../../utils/validators.dart';

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
      title: const CustomAuthAppBar(),
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
                style: fs20BlackBold,
              ),
            ),
            const Text(
              'Looks like you don’t have an account. Let’s create a new account for you.',
              style: fs14BlackRegular,
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
                style: fs14BlackRegular,
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
                      showCustomDialog(
                          context: context,
                          children: [
                            SizedBox(height: 10.h),
                            const Text(
                              'Verification Code',
                              style: fs16BlackRegular,
                            ),
                            SizedBox(height: 8.h),
                            CustomTextField(
                              hintText: 'Verification Code',
                              controller: verificationCodeController,
                              icon: const Icon(Icons.verified_outlined),
                              isPassword: true,
                              errorText: '',
                            ),
                          ],
                          buttonText: 'Complete Verification',
                          onButtonPress: () {
                            getBloc().attemptUserSignUpVerification(
                                emailInputController.text,
                                verificationCodeController.text, (response) {
                              if (response.isSignUpComplete) {
                                showMessageBar(
                                    'User is verified!\nContinue to login');
                              } else {
                                showMessageBar('Please try again later!');
                              }
                            }, (errorMsg) {
                              showMessageBar('Something went wrong!');
                            });
                          });
                      showMessageBar(
                          'OTP sent to your ${emailInputController.text}');
                    }
                  }, (errorMsg) {
                    showMessageBar(errorMsg);
                  });
                }
              },
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 20),
            Text.rich(
              TextSpan(
                text: "Already have an account? ",
                style: fs14BlackRegular.copyWith(color: fromHex('#A1A1A1')),
                children: <TextSpan>[
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => navigateToLoginScreen(),
                    text: 'Sign In',
                    style: const TextStyle(
                        color: Colors.blueAccent, fontFamily: 'Lexend'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void navigateToLoginScreen() =>
      Navigator.of(context).pushReplacement(LoginScreen.route());

  @override
  SignupScreenBloc getBloc() => _bloc;
}
