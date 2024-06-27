import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/utils/extension_functions.dart';
import 'package:estonedge/data/remote/repository/auth/auth_repository.dart';
import 'package:estonedge/utils/shared_pref.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/remote/repository/user/user_repository.dart';
import '../../../data/remote/requests/user/create_user_request.dart';

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

  void createUserRecord() {
    /// fetch user attributes
    apiGetUserAttributes((attrList) {
      /// update shared prefs
      updateSharedPrefs(attrList);

      print('UserName ---> ${attrList.getUsername()}');

      String createUserRequestParams = CreateUserRequestParameters(
          name: attrList.getUsername(), email: attrList.getUserEmail())
          .toRequestParams();

      print('Create User Request Params --> $createUserRequestParams');

      /// call create user record api by passing required request params
      apiCreateUserRecord(createUserRequestParams, (createUserResponse) {
        // print(createUserResponse.userId);
      }, (errorMsg) {
        // print(errorMsg);
      });
    }, (errorMsg) {
      // print(errorMsg);
    });
  }

  void updateSharedPrefs(List<AuthUserAttribute> attrList) {
    saveUserId(attrList.getUserId());
    saveUserName(attrList.getUsername());
    saveUserEmail(attrList.getUserEmail());
  }

  @override
  void dispose() {
    signInResult.close();
    super.dispose();
  }
}
