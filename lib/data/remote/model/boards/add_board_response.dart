import 'dart:convert';

import 'package:estonedge/data/remote/model/user/user_response.dart';

AddBoardResponse addBoardResponseFromJson(String str) =>
    AddBoardResponse.fromJson(json.decode(str));

String addBoardResponseToJson(AddBoardResponse data) =>
    json.encode(data.toJson());

class AddBoardResponse {
  final String message;
  final String boardId;
  final UpdatedAttributes updatedAttributes;

  AddBoardResponse({
    required this.message,
    required this.boardId,
    required this.updatedAttributes,
  });

  factory AddBoardResponse.fromJson(Map<String, dynamic> json) {
    return AddBoardResponse(
      message: json["message"] ?? '',
      boardId: json["board_id"] ?? '',
      updatedAttributes:
          UpdatedAttributes.fromJson(json["updatedAttributes"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "board_id": boardId,
      "updatedAttributes": updatedAttributes.toJson(),
    };
  }
}

class UpdatedAttributes {
  final List<Room> rooms;

  UpdatedAttributes({
    required this.rooms,
  });

  factory UpdatedAttributes.fromJson(Map<String, dynamic> json) {
    return UpdatedAttributes(
      rooms: (json["rooms"]?["L"] as List? ?? [])
          .map((e) => Room.fromJson(e["M"] ?? {}))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "rooms": {
        "L": rooms.map((room) => {"M": room.toJson()}).toList(),
      },
    };
  }
}
