import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:estonedge/data/remote/model/auth/login/login_response.dart';
import 'package:estonedge/data/remote/model/auth/signup/signup_response.dart';

class AuthRepository {
  /// methods for sign up

  /// signup method without email verification
  /// @required params - email, password, name
  Future<SignUpResponse> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      return SignUpResponse(
          signUpResult: await Amplify.Auth.signUp(
              username: email,
              password: password,
              options:
                  SignUpOptions(userAttributes: <AuthUserAttributeKey, String>{
                AuthUserAttributeKey.name: name,
              })));
    } on UsernameExistsException {
      return SignUpResponse(
          signUpException: SignUpException.USER_ALREADY_EXISTS);
    } on AuthValidationException {
      return SignUpResponse(
          signUpException: SignUpException.INVALID_FORM_FIELD);
    } catch (ex) {
      return SignUpResponse(signUpException: SignUpException.SERVER_ERROR);
    }
  }

  /// signup method to complete email verification
  /// @required params - email, verificationCode
  Future<SignUpResponse> verifyEmail({
    required String email,
    required String verificationCode,
  }) async {
    try {
      return SignUpResponse(
          signUpResult: await Amplify.Auth.confirmSignUp(
              username: email, confirmationCode: verificationCode));
    } on CodeMismatchException {
      return SignUpResponse(signUpException: SignUpException.CODE_MISMATCH);
    } on CodeDeliveryFailureException {
      return SignUpResponse(
          signUpException: SignUpException.CODE_DELIVERY_FAILED);
    } catch (ex) {
      return SignUpResponse(signUpException: SignUpException.SERVER_ERROR);
    }
  }

  ///-------------------------------------------------------------------------------------------------------
  /// methods for login

  /// login method to login to already created account
  /// @required params - email, password
  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    try {
      return LoginResponse(
          signInResult:
              await Amplify.Auth.signIn(username: email, password: password));
    } catch (ex) {
      print(ex.toString());
      return LoginResponse(loginException: LoginException.SERVER_ERROR);
    }
  }

  ///-------------------------------------------------------------------------------------------------------

  /// isUserSessionActive method to check if user is already logged in to system.
  Future<bool> isUserSessionActive() async {
    try {
      return (await Amplify.Auth.fetchAuthSession()).isSignedIn;
    } catch (ex) {
      print(ex.toString());
      return false;
    }
  }

  Future<void> getUserAttributes() async {
    String userName = (await Amplify.Auth.getCurrentUser()).username;

    print(userName);

    List<AuthUserAttribute> userAttributes =
        await Amplify.Auth.fetchUserAttributes();

    for (final element in userAttributes) {
      safePrint('key: ${element.userAttributeKey}; value: ${element.value}');
    }
  }

  /// logout method to destroy authSession in AWS Amplify
  Future<bool> logout() async {
    try {
      await Amplify.Auth.signOut();
      return true;
    } catch (ex) {
      print(ex.toString());
      return false;
    }
  }
}
