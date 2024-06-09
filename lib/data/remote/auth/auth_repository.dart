import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';

class AuthRepository {
  Future<String> initiateSignUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      await Amplify.Auth.signUp(
          username: email,
          password: password,
          options: SignUpOptions(userAttributes: <AuthUserAttributeKey, String>{
            AuthUserAttributeKey.name: name,
          }));

      return "Success";
    } on AuthException catch (ex) {
      return ex.toString();
    }
  }

  Future<String> completeSignUp({
    required String email,
    required String verificationCode,
  }) async {
    try {
      await Amplify.Auth.confirmSignUp(
          username: email, confirmationCode: verificationCode);

      return "Success";
    } on AuthException catch (ex) {
      return ex.toString();
    }
  }
}
