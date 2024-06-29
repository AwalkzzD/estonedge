import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_components.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_textfield.dart';
import 'package:estonedge/base/widgets/custom_page_route.dart';
import 'package:estonedge/ui/auth/login/login_screen_bloc.dart';
import 'package:estonedge/ui/auth/signup/signup_screen.dart';
import 'package:estonedge/ui/auth/utils/custom_auth_app_bar.dart';
import 'package:estonedge/ui/home/home_screen.dart';
import 'package:estonedge/utils/validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../base/src_constants.dart';

class LoginScreen extends BasePage {
  const LoginScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _LoginScreenState();

  static Route<dynamic> route() {
    return CustomPageRoute(builder: (context) => const LoginScreen());
  }
}

class _LoginScreenState extends BasePageState<LoginScreen, LoginScreenBloc> {
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();
  final TextEditingController verificationCodeController =
      TextEditingController();

  final LoginScreenBloc _bloc = LoginScreenBloc();

  bool isLoading = false;

  String? emailError;
  String? passwordError;

  @override
  void dispose() {
    emailInputController.dispose();
    passwordInputController.dispose();
    verificationCodeController.dispose();
    super.dispose();
  }

  void _forgotPassword() {}

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
                'SIGN IN',
                textAlign: TextAlign.left,
                style: fs20BlackBold,
              ),
            ),
            const Text('Welcome back! Sign in to control your smart home.',
                style: fs14BlackRegular),
            const SizedBox(height: 30),
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
            const SizedBox(height: 10),
            InkWell(
              onTap: _forgotPassword,
              child: const Text(
                "Forgot Password?",
                style: fs14BlueRegular,
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(
              btnText: 'LOGIN',
              onPressed: () {
                setState(() {
                  emailError = validateEmail(emailInputController.text);
                  passwordError =
                      validatePassword(passwordInputController.text);
                });
                if (emailError == null && passwordError == null) {
                  getBloc().attemptLogin(
                      emailInputController.text, passwordInputController.text,
                      (response) {
                    if (response.isSignedIn) {
                      showMessageBar('Welcome to EstonEdge');
                      getBloc().createUserRecord();
                      navigateToHomeScreen();
                    } else {
                      print(response);
                      if (response.nextStep.signInStep ==
                          AuthSignInStep.confirmSignUp) {
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
                            'Verification Incomplete\nEnter verification code sent on ${emailInputController.text}');
                      } else {
                        showMessageBar('Something went wrong');
                      }
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
                text: "Don't have an account? ",
                style: fs14BlackRegular.copyWith(color: fromHex('#A1A1A1')),
                children: <TextSpan>[
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => navigateToSignUpScreen(),
                    text: 'Sign Up',
                    style: const TextStyle(
                        color: Colors.blueAccent, fontFamily: 'Lexend'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToSignUpScreen() =>
      Navigator.of(context).pushReplacement(SignupScreen.route());

  void navigateToHomeScreen() =>
      Navigator.of(context).pushReplacement(HomeScreen.route());

  @override
  LoginScreenBloc getBloc() => _bloc;
}
