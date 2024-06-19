import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/data/remote/model/rooms/rooms_response.dart';
import 'package:rxdart/rxdart.dart';

import '../../../data/remote/repository/rooms/rooms_repository.dart';

class RoomScreenBloc extends BasePageBloc {
  late BehaviorSubject<List<RoomsResponse>> roomList;

  get roomListStream => roomList.stream;

  RoomScreenBloc() {
    roomList = BehaviorSubject.seeded([]);
  }

  void getRooms() {
    showLoading();
    apiGetRoomsData((response) {
      hideLoading();
      roomList.add(response);
    }, (error) {
      hideLoading();
      print('Error fetching data');
    });
  }
}
