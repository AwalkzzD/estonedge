import 'package:estonedge/data/remote/repository/auth/auth_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

class HomeScreenProvider {
  late BehaviorSubject<String> userName;

  get userNameStream => userName.stream;

  HomeScreenProvider() {
    userName = BehaviorSubject.seeded('User');
  }

/*getUserAttributes() {
    final authAttributesList = apiGetUserAttributes();
    authAttributesList.then((attributeList) {
      userName.add(attributeList.getUsername());
    });
  }*/
}

final userNameProvider = FutureProvider((ref) {
  return ref.read(authRepositoryProvider).getUserAttributes();
});
