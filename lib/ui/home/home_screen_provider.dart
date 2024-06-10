import 'package:estonedge/data/remote/repository/auth/auth_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userNameProvider = FutureProvider((ref) {
  return ref.read(authRepositoryProvider).getUserAttributes();
});
