import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/data/remote/repository/auth/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

class LoginScreenBloc extends BasePageBloc {
  late BehaviorSubject<SignInResult?> signInResult;
  get signInResultStream => signInResult.stream;

  LoginScreenBloc() {
    signInResult = BehaviorSubject.seeded(null);
  }

  void attemptLogin(String email, String password,
      Function(SignInResult) onSuccess, Function(String) onError) {
    showLoading();
    apiUserLogin(email, password, (response) {
      hideLoading();
      signInResult.add(response);
      onSuccess(response);
    }, (errorMsg) {
      hideLoading();
      onError(errorMsg);
    });
  }

  @override
  void dispose() {
    signInResult.close();
    super.dispose();
  }
}
