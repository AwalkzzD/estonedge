import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';
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

  Future<List<AuthUserAttribute>> getUserAttributes() async {
    List<AuthUserAttribute> userAttributes =
        await Amplify.Auth.fetchUserAttributes();

    return userAttributes;
  }

  /// forgot password method to reset password

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

void apiGetUserAttributes(
    Function(List<AuthUserAttribute>) onSuccess, Function() onError) async {
  try {
    await Amplify.Auth.fetchUserAttributes().then((attrList) {
      onSuccess(attrList);
    });
  } catch (ex) {
    onError;
  }
}

void apiUserLogin(String email, String password,
    Function(SignInResult) onSuccess, Function(String) onError) async {
  try {
    final response =
        await Amplify.Auth.signIn(username: email, password: password);
    onSuccess(response);
  } on UserNotFoundException catch (ex) {
    onError(ex.message);
  } on DioException catch (ex) {
    onError(ex.message ?? "Something went wrong");
  } catch (ex) {
    onError(ex.toString());
  }
}

void apiUserSignUp(
  String email,
  String password,
  String name,
  Function(SignUpResult) onSuccess,
  Function(String) onError,
) async {
  try {
    final response = await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: SignUpOptions(userAttributes: <AuthUserAttributeKey, String>{
          AuthUserAttributeKey.name: name,
        }));
    onSuccess(response);
  } on UsernameExistsException catch (ex) {
    onError(ex.message);
  } on AuthValidationException catch (ex) {
    onError(ex.message);
  } catch (ex) {
    onError(ex.toString());
  }
}

/// signup method to complete email verification
/// @required params - email, verificationCode
void apiUserSignUpVerification(
  String email,
  String verificationCode,
  Function(SignUpResult) onSuccess,
  Function(String) onError,
) async {
  try {
    final response = await Amplify.Auth.confirmSignUp(
      username: email,
      confirmationCode: verificationCode,
    );
    onSuccess(response);
  } on CodeMismatchException catch (ex) {
    onError(ex.message);
  } on CodeDeliveryFailureException catch (ex) {
    onError(ex.message);
  } catch (ex) {
    onError(ex.toString());
  }
}

void apiLogout(
    Function(SignOutResult) onSuccess, Function(String) onError) async {
  try {
    final response = await Amplify.Auth.signOut();
    onSuccess(response);
  } catch (ex) {
    onError(ex.toString());
  }
}
