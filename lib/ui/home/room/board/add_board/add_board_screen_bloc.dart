import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/data/remote/model/board_types/board_types_response.dart';
import 'package:estonedge/data/remote/repository/boards/boards_repository.dart';
import 'package:rxdart/rxdart.dart';

class AddBoardScreenBloc extends BasePageBloc {
  late BehaviorSubject<List<BoardTypesResponse>> boardTypes;
  late BehaviorSubject<List<String>> switchTypes;
  late BehaviorSubject<String?> selectedBoard;
  late BehaviorSubject<String?> selectedSwitch;
  late BehaviorSubject<String?> selectedRoomId;

  get boardTypesStream => boardTypes.stream;

  get switchTypesStream => switchTypes.stream;

  AddBoardScreenBloc() {
    boardTypes = BehaviorSubject.seeded([]);
    switchTypes = BehaviorSubject.seeded([]);
    selectedBoard = BehaviorSubject.seeded(null);
    selectedSwitch = BehaviorSubject.seeded(null);
    selectedRoomId = BehaviorSubject.seeded(null);
  }

  void getBoardTypes(Function(String) onError) {
    showLoading();
    apiGetBoardTypes((response) {
      hideLoading();
      boardTypes.add(response);
    }, (errorMsg) {
      hideLoading();
      onError(errorMsg);
    });
  }

  void getSwitchTypes(String boardType) {
    switchTypes.add(boardTypes.value
        .firstWhere((board) => board.boardType == boardType)
        .switchTypes
        .L
        .map((switchType) => switchType.type)
        .toList());
  }

  void saveRoomId(String roomId) {
    selectedRoomId.add(roomId);
  }
}
