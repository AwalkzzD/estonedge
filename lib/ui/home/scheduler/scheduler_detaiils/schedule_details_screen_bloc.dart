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

  void checkSchedule(
      Function(
        String roomId,
        String boardId,
        String switchId,
        String macAddress,
      ) onSuccess,
      Function(String) onError) {
    print(selectedRoom.value);
    print(selectedBoard.value);
    print(selectedSwitch.value);
    if (selectedRoom.value != null &&
        selectedBoard.value != null &&
        selectedSwitch.value != null) {
      try {
        final room1 = roomList.value.firstWhere((room) =>
            selectedRoom.value == '${room.roomName} - #${room.roomId}');
        try {
          final board1 = room1.boards.firstWhere((board) =>
              selectedBoard.value == '${board.boardName} - #${board.boardId}');
          try {
            board1.switches.firstWhere((switchX) =>
                selectedSwitch.value ==
                '${switchX.switchName} - #${switchX.switchId}');
            if (board1.macAddress.isNotEmpty) {
              onSuccess(selectedRoom.value!, selectedBoard.value!,
                  selectedSwitch.value!, board1.macAddress);
            } else {
              onError(
                  'Board is not configured\nPlease configure before creating a schedule');
            }
          } catch (ex) {
            onError('Invalid Switch selection');
          }
        } catch (ex) {
          onError('Invalid Board selection');
        }
      } catch (ex) {
        onError('Invalid Room selection');
        print(ex.toString());
      }
    } else {
      onError('Select all required fields');
    }
  }

  @override
  void dispose() {
    roomList.close();
    boardList.close();
    switchList.close();

    selectedRoom.close();
    selectedBoard.close();
    selectedSwitch.close();
    super.dispose();
  }
}
