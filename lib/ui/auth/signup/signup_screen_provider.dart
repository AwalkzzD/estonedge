import 'package:estonedge/data/remote/model/auth/signup/signup_response.dart';
import 'package:estonedge/data/remote/repository/auth/auth_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// signUp provider to get instance of AuthRepository and call signUp method
final signUpProvider = FutureProvider.autoDispose
    .family<SignUpResponse, List<String>>((ref, signUpParams) {
  return ref.read(authRepositoryProvider).signUp(
      email: signUpParams[0], password: signUpParams[1], name: signUpParams[2]);
});

/// verifyEmail Provider to get instance of AuthRepository and call verifyEmail method
final verifyEmailProvider = FutureProvider.autoDispose
    .family<SignUpResponse, List<String>>((ref, signUpParams) {
  return ref
      .read(authRepositoryProvider)
      .verifyEmail(email: signUpParams[0], verificationCode: signUpParams[1]);
});
