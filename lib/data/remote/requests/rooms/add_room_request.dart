import 'dart:convert';

class AddRoomRequestParameters {
  String? roomId;
  String? roomName;
  String? roomImage;

  AddRoomRequestParameters({this.roomId, this.roomName, this.roomImage});

  String toRequestParams() => json.encode(
      {"room_id": roomId, "room_name": roomName, "room_image": roomImage});
}
