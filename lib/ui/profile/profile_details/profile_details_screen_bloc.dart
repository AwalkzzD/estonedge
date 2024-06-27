import 'package:rxdart/rxdart.dart';

import '../../../base/src_bloc.dart';

class ProfileDetailsScreenBloc extends BasePageBloc {
  late BehaviorSubject<String?> gender;

  ProfileDetailsScreenBloc() {
    gender = BehaviorSubject.seeded(null);
  }

  void saveGender(String gender1) {
    gender.add(gender1);
  }
}
