import 'dart:convert';

List<BoardTypesResponse> boardTypesResponseFromJson(String str) =>
    List<BoardTypesResponse>.from(
        json.decode(str).map((x) => BoardTypesResponse.fromJson(x)));

String boardTypesResponseToJson(List<BoardTypesResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BoardTypesResponse {
  final SwitchTypes switchTypes;
  final String boardType;

  BoardTypesResponse({
    required this.switchTypes,
    required this.boardType,
  });

  factory BoardTypesResponse.fromJson(Map<String, dynamic> json) {
    return BoardTypesResponse(
      switchTypes: SwitchTypes.fromJson(json["switchTypes"] ?? {}),
      boardType: json["boardType"]?["S"] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "switchTypes": switchTypes.toJson(),
      "boardType": {"S": boardType},
    };
  }
}

class SwitchTypes {
  final List<SwitchType> L;

  SwitchTypes({
    required this.L,
  });

  factory SwitchTypes.fromJson(Map<String, dynamic> json) {
    return SwitchTypes(
      L: (json["L"] as List? ?? [])
          .map((e) => SwitchType.fromJson(e["M"] ?? {}))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "L": L.map((e) => {"M": e.toJson()}).toList(),
    };
  }
}

class SwitchType {
  final String type;
  final int fan;
  final int switchCount;

  SwitchType({
    required this.type,
    required this.fan,
    required this.switchCount,
  });

  factory SwitchType.fromJson(Map<String, dynamic> json) {
    return SwitchType(
      type: json["type"]?["S"] ?? '',
      fan: int.tryParse(json["fan"]?["N"] ?? '') ?? 0,
      switchCount: int.tryParse(json["switch"]?["N"] ?? '') ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": {"S": type},
      "fan": {"N": fan.toString()},
      "switch": {"N": switchCount.toString()},
    };
  }
}