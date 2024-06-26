import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/base/src_utils.dart';
import 'package:estonedge/data/remote/model/board_types/board_types_response.dart';
import 'package:estonedge/data/remote/model/boards/add_board_response.dart';
import 'package:estonedge/data/remote/repository/boards/boards_repository.dart';
import 'package:estonedge/data/remote/requests/boards/add_board_request.dart';
import 'package:rxdart/rxdart.dart';

class AddBoardScreenBloc extends BasePageBloc {
  late BehaviorSubject<List<BoardTypesResponse>> boardTypes;
  late BehaviorSubject<List<SwitchType>> switchTypes;
  late BehaviorSubject<String?> selectedBoard;
  late BehaviorSubject<String?> selectedSwitch;
  late BehaviorSubject<String?> selectedRoomId;
  late BehaviorSubject<List<Switch>> switchList;

  get boardTypesStream => boardTypes.stream;

  get switchTypesStream => switchTypes.stream;

  AddBoardScreenBloc() {
    boardTypes = BehaviorSubject.seeded([]);
    switchTypes = BehaviorSubject.seeded([]);
    selectedBoard = BehaviorSubject.seeded(null);
    selectedSwitch = BehaviorSubject.seeded(null);
    selectedRoomId = BehaviorSubject.seeded(null);
    switchList = BehaviorSubject.seeded([]);
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
    final List<SwitchType> switches = boardTypes.value
        .firstWhere((board) => board.boardType == boardType)
        .switchTypes
        .L;

    switchTypes.add(switches);
  }

  void saveRoomId(String roomId) {
    selectedRoomId.add(roomId);
  }

  void saveBoard(String boardType) {
    selectedBoard.add(boardType);
  }

  void saveSwitch(String switchType) {
    selectedSwitch.add(switchType);
    saveSwitchList(switchType);
  }

  void addBoard(
      Function(AddBoardResponse) onSuccess, Function(String) onError) {
    String boardId = generateUniqueKey();
    String addBoardRequestParameters = AddBoardRequestParameters(
            boardId: boardId,
            boardName: 'Board#$boardId',
            boardModel: selectedBoard.value ?? "",
            macAddress: "",
            switches: switchList.value)
        .toRequestParams();

    print('Add Board Request Params ---> $addBoardRequestParameters');

    if (selectedBoard.value != null &&
        selectedSwitch.value != null &&
        selectedRoomId.value != null) {
      showLoading();
      apiAddBoardData(
        roomId: selectedRoomId.value ?? "",
        addBoardRequestParams: addBoardRequestParameters,
        onSuccess: (response) {
          hideLoading();
          onSuccess(response);
        },
        onError: (errorMsg) {
          hideLoading();
          onError(errorMsg);
        },
      );
    }
  }

  void saveSwitchList(String switchType) {
    switchList.add(generateSwitchesForBoardType(switchType));
  }

  List<Switch> generateSwitchesForBoardType(String switchTypeName) {
    List<Switch> switches = [];

    // Find the board type that matches the switchTypeName
    BoardTypesResponse? matchingBoardType;
    for (var boardType in boardTypes.value) {
      for (var switchType in boardType.switchTypes.L) {
        if (switchType.type == switchTypeName) {
          matchingBoardType = boardType;
          break;
        }
      }
      if (matchingBoardType != null) {
        break;
      }
    }

    if (matchingBoardType == null) {
      print('No matching board type found for switch type: $switchTypeName');
      return switches;
    }

    // Find the specific switch type within the matching board type
    SwitchType? matchingSwitchType;
    for (var switchType in matchingBoardType.switchTypes.L) {
      if (switchType.type == switchTypeName) {
        matchingSwitchType = switchType;
        break;
      }
    }

    if (matchingSwitchType == null) {
      print(
          'No matching switch type found within the board type: $switchTypeName');
      return switches;
    }

    // Generate the switches based on the matching switch type
    for (int i = 0; i < matchingSwitchType.switchCount; i++) {
      String switchId = generateUniqueKey();
      switches.add(
        Switch(
          switchId: switchId,
          switchName: 'Switch#$switchId',
          switchType: 'On/Off',
          status: false,
        ),
      );
    }
    for (int i = 0; i < matchingSwitchType.fan; i++) {
      String switchId = generateUniqueKey();
      switches.add(
        Switch(
          switchId: switchId,
          switchName: 'Fan#$switchId',
          switchType: 'Speed Control',
          status: false,
        ),
      );
    }

    return switches;
  }
}
