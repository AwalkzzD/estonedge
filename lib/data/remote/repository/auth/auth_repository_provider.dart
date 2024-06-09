import 'package:estonedge/data/remote/repository/auth/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Auth Repository instance provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

/// Uses Session Details provider
/// returns - bool whether user session is active or not.
final userSessionProvider = Provider.autoDispose((ref) {
  return ref.read(authRepositoryProvider).isUserSessionActive();
});
