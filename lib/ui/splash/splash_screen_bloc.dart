import 'package:estonedge/data/remote/repository/auth/auth_repository.dart';

import '../../base/src_bloc.dart';

class SplashScreenBloc extends BasePageBloc {
  void checkUserSession(Function(bool) onSuccess, Function(String) onError) {
    apiCheckUserSession((isActive) {
      onSuccess(isActive);
    }, (errorMsg) {
      onError(errorMsg);
    });
  }
}
