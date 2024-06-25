import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/data/remote/model/rooms/get_rooms/rooms_response.dart';
import 'package:estonedge/data/remote/repository/rooms/rooms_repository.dart';
import 'package:rxdart/rxdart.dart';

class ScheduleDetailsScreenBloc extends BasePageBloc {
  late BehaviorSubject<List<RoomsResponse>> roomList;
  get roomListStream => roomList.stream;

  ScheduleDetailsScreenBloc() {
    roomList = BehaviorSubject.seeded([]);
  }

  void getRooms() {
    showLoading();
    apiGetRoomsData((response) {
      hideLoading();
      roomList.add(response);
    }, (error) {
      hideLoading();
      print('Error fetching data: $error');
    });
  }
}
