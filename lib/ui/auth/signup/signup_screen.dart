import 'package:estonedge/base/screens/base_widget.dart';
import 'package:estonedge/base/utils/widgets/custom_button.dart';
import 'package:estonedge/base/utils/widgets/custom_textfield.dart';
import 'package:estonedge/ui/auth/signup/signup_screen_provider.dart';
import 'package:estonedge/ui/auth/utils/custom_auth_app_bar.dart';
import 'package:flutter/material.dart';

class SignupScreen extends BaseWidget {
  const SignupScreen({super.key});

  @override
  BaseWidgetState<BaseWidget> getState() => _SignupScreenState();
}

class _SignupScreenState extends BaseWidgetState<SignupScreen> {
  final TextEditingController nameInputController = TextEditingController();
  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();
  final TextEditingController verificationCodeController =
      TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    nameInputController.dispose();
    emailInputController.dispose();
    passwordInputController.dispose();
    verificationCodeController.dispose();
    super.dispose();
  }

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
            Visibility(
                visible: isLoading,
                replacement: CustomButton(
                  btnText: 'CREATE ACCOUNT',
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    ref
                        .read(signUpProvider([
                      emailInputController.text,
                      passwordInputController.text,
                      nameInputController.text
                    ]).future)
                        .then((signUpResponse) {
                      if (signUpResponse.signUpResult != null) {
                        setState(() {
                          isLoading = false;
                        });
                        verifyEmail(email: emailInputController.text);
                      } else {
                        showSnackBar(signUpResponse.signUpException.name);
                      }
                    }).catchError((error) {
                      getErrorView();
                    });
                  },
                  width: double.infinity,
                  color: Colors.blueAccent,
                ),
                child: getLoadingView()),
          ],
        ),
      ),
    );
  }

  void verifyEmail({required String email}) {
    showDialog(
      context: context,
      barrierDismissible: false,
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
                  ref
                      .read(verifyEmailProvider([
                    emailInputController.text,
                    verificationCodeController.text
                  ]).future)
                      .then((signUpResponse) {
                    if (signUpResponse.signUpResult != null) {
                      Navigator.of(context).pop();
                      navigateToLoginScreen();
                    } else {
                      showSnackBar(signUpResponse.signUpException.name);
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.of(context).pop();
                    }
                  }).catchError((error) {
                    getErrorView();
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  void navigateToLoginScreen() =>
      Navigator.pushReplacementNamed(context, '/login');
}
