import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/data/remote/model/rooms/rooms_response.dart';
import 'package:estonedge/utils/shared_pref.dart';
import 'package:rxdart/rxdart.dart';

class DashboardScreenBloc extends BasePageBloc {
  late BehaviorSubject<List<RoomsResponse>> roomsList;

  get roomListStream => roomsList.stream;

  DashboardScreenBloc() {
    roomsList = BehaviorSubject.seeded([]);
  }

  void getRooms() {
    roomsList.add(getRoomsList());
  }
}
