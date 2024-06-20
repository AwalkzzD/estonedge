import 'dart:convert';

class AddRoomRequestParameters {
  String? roomId;
  String? roomName;

  AddRoomRequestParameters({this.roomId, this.roomName});

  String toRequestParams() =>
      json.encode({"room_id": roomId, "room_name": roomName});
}
