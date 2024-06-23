import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/data/remote/repository/auth/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

class SignupScreenBloc extends BasePageBloc {
  late BehaviorSubject<SignUpResult?> signUpResult;

  get signUpResultStream => signUpResult.stream;

  SignupScreenBloc() {
    signUpResult = BehaviorSubject.seeded(null);
  }

  void attemptSignUp(String email, String password, String name,
      Function(SignUpResult) onSuccess, Function(String) onError) {
    showLoading();
    apiUserSignUp(email, password, name, (response) {
      hideLoading();
      signUpResult.add(response);
      onSuccess(response);
    }, (errorMsg) {
      hideLoading();
      onError(errorMsg);
    });
  }

  void attemptUserSignUpVerification(String email, String verificationCode,
      Function(SignUpResult) onSuccess, Function(String) onError) {
    showLoading();
    apiUserSignUpVerification(email, verificationCode, (response) {
      hideLoading();
      signUpResult.add(response);
      onSuccess(response);
    }, (errorMsg) {
      hideLoading();
      onError(errorMsg);
    });
  }

  @override
  void dispose() {
    signUpResult.close();
    super.dispose();
  }
}
