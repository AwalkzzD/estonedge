import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/data/remote/model/boards/delete_board_response.dart';
import 'package:estonedge/data/remote/model/boards/update_board_response.dart';
import 'package:estonedge/data/remote/model/rooms/delete_room/delete_room_response.dart';
import 'package:estonedge/data/remote/model/rooms/get_rooms/rooms_response.dart';
import 'package:estonedge/data/remote/repository/boards/boards_repository.dart';
import 'package:estonedge/data/remote/repository/rooms/rooms_repository.dart';
import 'package:estonedge/data/remote/requests/boards/update_board_request.dart';
import 'package:rxdart/rxdart.dart';

class RoomDetailsScreenBloc extends BasePageBloc {
  late BehaviorSubject<RoomsResponse?> roomDetails;

  get roomDetailsStream => roomDetails.stream;

  RoomDetailsScreenBloc() {
    roomDetails = BehaviorSubject.seeded(null);
  }

  void getRoomData(String roomId, Function(String) onError) {
    showLoading();
    apiGetRoomData(roomId, (response) {
      hideLoading();
      roomDetails.add(response);
    }, (errorMsg) {
      hideLoading();
      onError(errorMsg);
    });
  }

  void deleteRoom(String roomId, Function(DeleteRoomResponse) onSuccess,
      Function(String) onError) {
    showLoading();
    apiDeleteRoom(roomId, (response) {
      hideLoading();
      onSuccess(response);
    }, (errorMsg) {
      hideLoading();
      onError(errorMsg);
    });
  }

  void updateBoard(String roomId, String boardId, String boardName,
      Function(UpdateBoardResponse) onSuccess, Function(String) onError) {
    showLoading();

    final updateBoardRequestParams =
        UpdateBoardRequestParameters(boardName: boardName).toRequestParams();

    apiUpdateBoardDetails(
        roomId: roomId,
        boardId: boardId,
        updateBoardRequestParams: updateBoardRequestParams,
        onSuccess: (response) {
          hideLoading();
          onSuccess(response);
        },
        onError: (errorMsg) {
          hideLoading();
          onError(errorMsg);
        });
  }

  void deleteBoard(String roomId, String boardId,
      Function(DeleteBoardResponse) onSuccess, Function(String) onError) {
    showLoading();

    apiDeleteBoardDetails(
        roomId: roomId,
        boardId: boardId,
        onSuccess: (response) {
          hideLoading();
          onSuccess(response);
        },
        onError: (errorMsg) {
          hideLoading();
          onError(errorMsg);
        });
  }

  @override
  void dispose() {
    roomDetails.close();
    super.dispose();
  }
}
