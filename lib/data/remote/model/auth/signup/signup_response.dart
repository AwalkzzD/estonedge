import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

enum SignUpException {
  NONE,
  USER_ALREADY_EXISTS,
  INVALID_FORM_FIELD,
  SERVER_ERROR,
  CODE_MISMATCH,
  CODE_DELIVERY_FAILED,
}

class SignUpResponse {
  final SignUpResult? signUpResult;
  final SignUpException signUpException;

  SignUpResponse(
      {this.signUpResult, this.signUpException = SignUpException.NONE});
}
