import 'package:estonedge/base/base_bloc.dart';
import 'package:estonedge/base/src_utils.dart';
import 'package:estonedge/data/remote/model/rooms/add_room_response.dart';
import 'package:estonedge/data/remote/requests/rooms/add_room_request.dart';

import '../../../../data/remote/repository/rooms/rooms_repository.dart';

class RoomImageScreenBloc extends BasePageBloc {
  void addRoom(String roomName, Function(AddRoomResponse) onSuccess,
      Function(String) onError) {
    String addRoomRequestParameters = AddRoomRequestParameters(
            roomId: generateUniqueKey(), roomName: roomName)
        .toRequestParams();

    showLoading();
    apiAddRoomData(addRoomRequestParameters, (addRoomResponse) {
      hideLoading();
      onSuccess(addRoomResponse);
    }, (error) {
      hideLoading();
      onError(error);
    });
  }
}
