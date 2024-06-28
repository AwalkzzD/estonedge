import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:dio/dio.dart';

void apiGetUserAttributes(Function(List<AuthUserAttribute>) onSuccess,
    Function(String) onError) async {
  try {
    await Amplify.Auth.fetchUserAttributes().then((attrList) {
      onSuccess(attrList);
    });
  } catch (ex) {
    onError(ex.toString());
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

void apiUpdatePassword(String oldPassword, String newPassword,
    Function(UpdatePasswordResult) onSuccess, Function(String) onError) async {
  try {
    final response = await Amplify.Auth.updatePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    onSuccess(response);
  } on AuthException catch (ex) {
    onError(ex.message);
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

void apiCheckUserSession(
    Function(bool) onSuccess, Function(String) onError) async {
  try {
    onSuccess((await Amplify.Auth.fetchAuthSession()).isSignedIn);
  } catch (ex) {
    onError(ex.toString());
  }
}
