import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_textfield.dart';
import 'package:estonedge/ui/auth/login/login_screen_bloc.dart';
import 'package:estonedge/ui/auth/utils/custom_auth_app_bar.dart';
import 'package:estonedge/ui/auth/validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../base/src_constants.dart';

class LoginScreen extends BasePage {
  const LoginScreen({super.key});

  @override
  BasePageState<BasePage<BasePageBloc?>, BasePageBloc> getState() =>
      _LoginScreenState();
}

class _LoginScreenState extends BasePageState<LoginScreen, LoginScreenBloc> {
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();

  final LoginScreenBloc _bloc = LoginScreenBloc();

  bool isLoading = false;

  String? emailError;
  String? passwordError;

  @override
  void dispose() {
    emailInputController.dispose();
    passwordInputController.dispose();
    super.dispose();
  }

  void navigateToSignUpScreen() =>
      Navigator.pushReplacementNamed(context, '/signup');

  void navigateToHomeScreen() {
    Navigator.of(context).popAndPushNamed('/home');
  }

  void _forgotPassword() {}

  @override
  Widget buildWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomAppBar(),
      ),
      body: SingleChildScrollView(
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
                  fontFamily: 'Rubik-W92V',
                  //fontWeight: FontWeight.bold
                ),
              ),
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
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Rubik-W92V',
                      color: Colors.blueAccent),
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
                        navigateToHomeScreen();
                      } else {
                        showMessageBar('Something went wrong');
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
                  text: "Don't have an account? ",
                  style: const TextStyle(
                    fontSize: 14,
                    fontFamily: 'Lexend',
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
      ),
    );
  }

  @override
  bool customBackPressed() => true;

  @override
  void onBackPressed(bool didPop, BuildContext context) {
    print('step 1');
    if (!didPop) {
      print('step 2');
      if (isDrawerOpen()) {
        print('step 3');
        closeDrawer();
      } else {
        print('step 4');
        hideSoftInput();
        SystemNavigator.pop();
      }
    }
  }

  @override
  LoginScreenBloc getBloc() => _bloc;
}
