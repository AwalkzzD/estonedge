import 'package:rxdart/rxdart.dart';

import 'base/src_bloc.dart';

class AppBloc extends BasePageBloc {
  late BehaviorSubject<int?> bottomNavIndex;

  AppBloc() {
    bottomNavIndex = BehaviorSubject.seeded(null);
  }

  void setBottomNavIndex(int index) {
    bottomNavIndex.add(index);
  }
}
