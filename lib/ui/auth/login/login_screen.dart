import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/base_page.dart';
import 'package:estonedge/base/constants/app_styles.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_textfield.dart';
import 'package:estonedge/ui/auth/login/login_screen_bloc.dart';
import 'package:estonedge/ui/auth/utils/custom_auth_app_bar.dart';
import 'package:estonedge/ui/auth/validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  void navigateToHomeScreen() =>
      Navigator.pushReplacementNamed(context, '/home');

  void _forgotPassword() {}

  @override
  Widget buildWidget(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop(); // Exit the app
        return false; // Prevent default back button behavior
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
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
                Text('Sign in to access your account.',
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
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Lexend',
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
                      getBloc().attemptLogin(emailInputController.text,
                          passwordInputController.text, (response) {
                        if (response.isSignedIn) {
                          navigateToHomeScreen();
                        } else {
                          print('Not Signed In');
                        }
                      }, (msg) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(msg)));
                      });
                    }
                  },
                  width: double.infinity,
                  color: Colors.blueAccent,
                ),
                const SizedBox(height: 20),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Don't have an account? ",
                      style: fs14BlackRegular,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  LoginScreenBloc getBloc() => _bloc;
}
