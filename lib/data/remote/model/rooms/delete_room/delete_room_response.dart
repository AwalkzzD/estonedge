// To parse this JSON data, do
//
//     final deleteRoomResponse = deleteRoomResponseFromJson(jsonString);

import 'dart:convert';

DeleteRoomResponse deleteRoomResponseFromJson(String str) =>
    DeleteRoomResponse.fromJson(json.decode(str));

String deleteRoomResponseToJson(DeleteRoomResponse data) =>
    json.encode(data.toJson());

class DeleteRoomResponse {
  String? message;

  DeleteRoomResponse({
    this.message,
  });

  factory DeleteRoomResponse.fromJson(Map<String, dynamic> json) =>
      DeleteRoomResponse(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
