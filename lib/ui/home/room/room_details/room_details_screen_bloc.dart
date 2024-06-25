import 'package:estonedge/base/src_bloc.dart';
import 'package:estonedge/data/remote/model/rooms/delete_room/delete_room_response.dart';
import 'package:estonedge/data/remote/repository/rooms/rooms_repository.dart';

class RoomDetailsScreenBloc extends BasePageBloc {
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
}
