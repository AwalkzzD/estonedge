import 'dart:convert';

class AddBoardRequestParameters {
  String? boardId;
  String? boardName;
  String? boardModel;
  String? macAddress;
  List<Switch>? switches;

  AddBoardRequestParameters({
    this.boardId,
    this.boardName,
    this.boardModel,
    this.macAddress,
    this.switches,
  });

  String toRequestParams() {
    return json.encode({
      "board_id": boardId,
      "board_name": boardName,
      "board_model": boardModel,
      "mac_address": macAddress,
      "switches": switches?.map((switchItem) => switchItem.toJson()).toList(),
    });
  }
}

class Switch {
  String? switchId;
  String? switchName;
  String? switchType;
  bool? status;

  Switch({
    this.switchId,
    this.switchName,
    this.switchType,
    this.status,
  });

  factory Switch.fromJson(Map<String, dynamic> json) {
    return Switch(
      switchId: json["switch_id"],
      switchName: json["switch_name"],
      switchType: json["switch_type"],
      status: json["status"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "switch_id": switchId,
      "switch_name": switchName,
      "switch_type": switchType,
      "status": status,
    };
  }
}
