import 'dart:convert';

import 'package:estonedge/data/remote/model/user/user_response.dart';

List<RoomsResponse> roomsResponseFromJson(String str) =>
    List<RoomsResponse>.from((json.decode(str)["L"] as List)
        .map((x) => RoomsResponse.fromJson(x["M"] ?? {})));

String roomsResponseToJson(List<RoomsResponse> data) => json.encode({
      "L": List<dynamic>.from(data.map((x) => {"M": x.toJson()}))
    });

class RoomsResponse {
  final String roomId;
  final String roomName;
  final String roomImage;
  final List<Board> boards;

  RoomsResponse({
    required this.roomId,
    required this.roomName,
    required this.roomImage,
    required this.boards,
  });

  factory RoomsResponse.fromJson(Map<String, dynamic> json) {
    return RoomsResponse(
      roomId: json["room_id"]?["S"] ?? '',
      roomName: json["room_name"]?["S"] ?? '',
      roomImage: json["room_image"]?["S"] ?? '',
      boards: (json["boards"]?["L"] as List? ?? [])
          .map((e) => Board.fromJson(e["M"] ?? {}))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "room_id": {"S": roomId},
      "room_name": {"S": roomName},
      "room_image": {"S": roomImage},
      "boards": {
        "L": boards.map((board) => {"M": board.toJson()}).toList()
      },
    };
  }
}
