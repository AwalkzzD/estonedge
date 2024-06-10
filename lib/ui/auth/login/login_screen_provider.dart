import 'package:estonedge/data/remote/model/auth/login/login_response.dart';
import 'package:estonedge/data/remote/repository/auth/auth_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// login Provider to get instance of AuthRepository and call login method
final loginProvider = FutureProvider.autoDispose
    .family<LoginResponse, List<String>>((ref, signUpParams) {
  return ref
      .read(authRepositoryProvider)
      .login(email: signUpParams[0], password: signUpParams[1]);
});
