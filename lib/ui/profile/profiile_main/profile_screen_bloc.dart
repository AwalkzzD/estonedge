import 'package:estonedge/data/remote/repository/auth/auth_repository.dart';

import '../../../base/src_bloc.dart';

class ProfileScreenBloc extends BasePageBloc {
  
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
}
