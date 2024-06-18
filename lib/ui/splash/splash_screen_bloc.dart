import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/data/remote/repository/auth/auth_repository.dart';

class SplashScreenBloc extends BasePageBloc {
  void checkUserSession(Function(bool) onSuccess, Function(String) onError) {
    apiCheckUserSession((isActive) {
      onSuccess(isActive);
    }, (errorMsg) {
      onError(errorMsg);
    });
  }
}
