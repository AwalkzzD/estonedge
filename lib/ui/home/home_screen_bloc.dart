import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/utils/extension_functions.dart';
import 'package:estonedge/data/remote/repository/auth/auth_repository.dart';
import 'package:estonedge/utils/shared_pref.dart';
import 'package:rxdart/rxdart.dart';

import '../../data/remote/repository/user/user_repository.dart';

class HomeScreenBloc extends BasePageBloc {
  late BehaviorSubject<String> userName;
  late BehaviorSubject<int> currentPageIndex;

  get userNameStream => userName.stream;

  get currentPageIndexStream => currentPageIndex.stream;

  HomeScreenBloc() {
    userName = BehaviorSubject.seeded('User');
    currentPageIndex = BehaviorSubject.seeded(0);
    getUserData();
  }

  void getUserAttributes(Function(String) onSuccess) {
    showLoading();
    apiGetUserAttributes((attrList) {
      hideLoading();
      userName.add(attrList.getUsername());
      onSuccess;
      saveUserId(attrList.getUserId());
    }, (errorMsg) {
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
      print('Home Screen Error ---> $error');
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

  void updateCurrentIndex(int index) {
    currentPageIndex.add(index);
  }
}
