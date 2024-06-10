import 'dart:async';

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Caching - ref.keepAlive() inside contentProvider is used to preserve the state so that request wont fire again if the user leaves
/// and re-enters the same screen.
///
/// Extension function to cache a provider ref for specified amount of time.
extension AutoDisposeRefCache on AutoDisposeRef {
  void cacheFor(int minutesDuration) {
    final link = keepAlive();
    final timer = Timer(Duration(minutes: minutesDuration), () => link.close());
    onDispose(() => timer.cancel());
  }
}

extension AuthUserAttributeExtensions on List<AuthUserAttribute> {
  String getUsername() {
    try {
      return firstWhere((attribute) =>
          attribute.userAttributeKey == AuthUserAttributeKey.name).value;
    } catch (e) {
      return 'User';
    }
  }
}
