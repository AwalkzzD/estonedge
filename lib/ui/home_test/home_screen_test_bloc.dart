import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/utils/extension_functions.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/remote/repository/auth/auth_repository.dart';
import '../../data/remote/repository/user/user_repository.dart';

class HomeScreenTestBloc extends BasePageBloc {
  late BehaviorSubject<String> userName;

  get userNameStream => userName.stream;

  HomeScreenTestBloc() {
    userName = BehaviorSubject.seeded('User');
    getUserData();
  }

  void getUserAttributes(Function(String) onSuccess) {
    showLoading();
    apiGetUserAttributes((attrList) {
      userName.add(attrList.getUsername());
      onSuccess;
      hideLoading();
    }, () {
      hideLoading();
    });
  }

  void getUserData() {
    showLoading();
    apiGetUserData((userResponse) {
      hideLoading();
      print(userResponse.toString());
    }, (error) {
      hideLoading();
      print(error);
    });
  }

  void logout() {
    showLoading();
    apiLogout((response) {
      hideLoading();
      print(response);
    }, (error) {
      hideLoading();
      print(error);
    });
  }

  @override
  void dispose() {
    userName.close();
    super.dispose();
  }
}
