import 'package:estonedge/data/remote/model/rooms/get_rooms/rooms_response.dart';
import 'package:estonedge/data/remote/model/user/user_response.dart';
import 'package:estonedge/data/remote/repository/rooms/rooms_repository.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../base/src_bloc.dart';

class ScheduleDetailsScreenBloc extends BasePageBloc {
  late BehaviorSubject<List<RoomsResponse>> roomList;
  late BehaviorSubject<List<Board>> boardList;
  late BehaviorSubject<List<Switch>> switchList;
  late BehaviorSubject<String?> selectedRoom;
  late BehaviorSubject<String?> selectedBoard;
  late BehaviorSubject<String?> selectedSwitch;

  get roomListStream => roomList.stream;

  get boardListStream => boardList.stream;

  get switchListStream => switchList.stream;

  ScheduleDetailsScreenBloc() {
    roomList = BehaviorSubject.seeded([]);
    boardList = BehaviorSubject.seeded([]);
    switchList = BehaviorSubject.seeded([]);

    selectedRoom = BehaviorSubject.seeded(null);
    selectedBoard = BehaviorSubject.seeded(null);
    selectedSwitch = BehaviorSubject.seeded(null);
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

  void checkSchedule(Function(bool) onSuccess, Function(String) onError) {
    print(selectedRoom.value);
    print(selectedBoard.value);
    print(selectedSwitch.value);
    if (selectedRoom.value != null &&
        selectedBoard.value != null &&
        selectedSwitch.value != null) {
      try {
        final room1 = roomList.value.firstWhere((room) =>
            selectedRoom.value == '${room.roomName} - #${room.roomId}');
        print(room1);
      } catch (ex) {
        print(ex.toString());
      }
    } else {
      onError('Select all required');
    }
  }

  String removeIdFromString(String input) {
    final regex = RegExp(r' - #[a-fA-F0-9-]+$');
    return input.replaceAll(regex, '');
  }
}
