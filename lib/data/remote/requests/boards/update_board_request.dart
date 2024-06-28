import 'dart:convert';

class UpdateBoardRequestParameters {
  String? boardName;
  String? macAddress;

  UpdateBoardRequestParameters({this.boardName, this.macAddress});

  String toRequestParams() => json.encode(
      {"board_name": boardName ?? "Board X", "mac_address": macAddress ?? ""});
}
