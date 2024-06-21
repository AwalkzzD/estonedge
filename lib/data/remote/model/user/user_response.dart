import 'dart:convert';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  final String userId;
  final String email;
  final String name;
  final AdditionalInfo additionalInfo;
  final List<Room> rooms;

  UserResponse({
    required this.userId,
    required this.email,
    required this.name,
    required this.additionalInfo,
    required this.rooms,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      userId: json["user_id"]?["S"] ?? '',
      email: json["email"]?["S"] ?? '',
      name: json["name"]?["S"] ?? '',
      additionalInfo: AdditionalInfo.fromJson(json["additional_info"]?["M"] ?? {}),
      rooms: (json["rooms"]?["L"] as List? ?? [])
          .map((e) => Room.fromJson(e["M"] ?? {}))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "user_id": {"S": userId},
      "email": {"S": email},
      "name": {"S": name},
      "additional_info": {"M": additionalInfo.toJson()},
      "rooms": {
        "L": rooms.map((room) => {"M": room.toJson()}).toList()
      },
    };
  }
}

class AdditionalInfo {
  final String? gender;
  final String? contactNo;
  final String? dob;

  AdditionalInfo({
    this.gender,
    this.contactNo,
    this.dob,
  });

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) {
    return AdditionalInfo(
      gender: json["gender"]?["S"],
      contactNo: json["contact_no"]?["S"],
      dob: json["dob"]?["S"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (gender != null) "gender": {"S": gender},
      if (contactNo != null) "contact_no": {"S": contactNo},
      if (dob != null) "dob": {"S": dob},
    };
  }
}

class Room {
  final String roomId;
  final String roomName;
  final String roomImage;
  final List<Board> boards;

  Room({
    required this.roomId,
    required this.roomName,
    required this.roomImage,
    required this.boards,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
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

class Board {
  final String boardId;
  final String boardName;
  final String boardModel;
  final String macAddress;
  final List<Switch> switches;

  Board({
    required this.boardId,
    required this.boardName,
    required this.boardModel,
    required this.macAddress,
    required this.switches,
  });

  factory Board.fromJson(Map<String, dynamic> json) {
    return Board(
      boardId: json["board_id"]?["S"] ?? '',
      boardName: json["board_name"]?["S"] ?? '',
      boardModel: json["board_model"]?["S"] ?? '',
      macAddress: json["mac_address"]?["S"] ?? '',
      switches: (json["switches"]?["L"] as List? ?? [])
          .map((e) => Switch.fromJson(e["M"] ?? {}))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "board_id": {"S": boardId},
      "board_name": {"S": boardName},
      "board_model": {"S": boardModel},
      "mac_address": {"S": macAddress},
      "switches": {
        "L": switches.map((switchItem) => {"M": switchItem.toJson()}).toList()
      },
    };
  }
}

class Switch {
  final String switchId;
  final String switchName;
  final String switchType;
  final bool status;

  Switch({
    required this.switchId,
    required this.switchName,
    required this.switchType,
    required this.status,
  });

  factory Switch.fromJson(Map<String, dynamic> json) {
    return Switch(
      switchId: json["switch_id"]?["S"] ?? '',
      switchName: json["switch_name"]?["S"] ?? '',
      switchType: json["switch_type"]?["S"] ?? '',
      status: json["status"] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "switch_id": {"S": switchId},
      "switch_name": {"S": switchName},
      "switch_type": {"S": switchType},
      "status": status,
    };
  }
}
