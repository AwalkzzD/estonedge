import 'package:estonedge/base/screens/base_widget.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_textfield.dart';
import 'package:estonedge/ui/auth/login/login_screen_provider.dart';
import 'package:estonedge/ui/auth/utils/custom_auth_app_bar.dart';
import 'package:estonedge/ui/auth/validators.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginScreen extends BaseWidget {
  const LoginScreen({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _LoginScreenState();
}

class _LoginScreenState extends BaseWidgetState<LoginScreen> {
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();

  bool isLoading = false;

  String? emailError;
  String? passwordError;

  @override
  void dispose() {
    emailInputController.dispose();
    passwordInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Visibility(
                visible: isLoading,
                replacement: CustomButton(
                  btnText: 'LOGIN',
                  onPressed: () {
                    setState(() {
                      emailError = validateEmail(emailInputController.text);
                      passwordError =
                          validatePassword(passwordInputController.text);
                    });

                    if (emailError == null && passwordError == null) {
                      setState(() {
                        isLoading = true;
                      });
                      ref
                          .read(loginProvider([
                        emailInputController.text,
                        passwordInputController.text,
                      ]).future)
                          .then((loginResponse) {
                        if (loginResponse.signInResult != null) {
                          setState(() {
                            isLoading = false;
                          });
                          navigateToHomeScreen();
                        } else {
                          showSnackBar(loginResponse.loginException.name);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }).catchError((error) {
                        getErrorView();
                      });
                    }
                  },
                  width: double.infinity,
                  color: Colors.blueAccent,
                ),
                child: getLoadingView(),
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
      ),
    );
  }

  void navigateToSignUpScreen() => Navigator.pushNamed(context, '/signup');

  void navigateToHomeScreen() =>
      Navigator.pushReplacementNamed(context, '/home');

  void _forgotPassword() {
    
  }
}
