    // To parse this JSON data, do
//
//     final addRoomResponse = addRoomResponseFromJson(jsonString);

import 'dart:convert';

AddRoomResponse addRoomResponseFromJson(String str) => AddRoomResponse.fromJson(json.decode(str));

String addRoomResponseToJson(AddRoomResponse data) => json.encode(data.toJson());

class AddRoomResponse {
  String? message;
  String? roomId;

  AddRoomResponse({
    this.message,
    this.roomId,
  });

  factory AddRoomResponse.fromJson(Map<String, dynamic> json) => AddRoomResponse(
    message: json["message"],
    roomId: json["room_id"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "room_id": roomId,
  };
}
