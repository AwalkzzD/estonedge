import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

enum LoginException {
  NONE,
  USER_ALREADY_EXISTS,
  INVALID_FORM_FIELD,
  SERVER_ERROR,
  CODE_MISMATCH,
  CODE_DELIVERY_FAILED,
}

class LoginResponse {
  final SignInResult? signInResult;
  final LoginException loginException;

  LoginResponse({this.signInResult, this.loginException = LoginException.NONE});
}
