// To parse this JSON data, do
//
//     final updateBoardResponse = updateBoardResponseFromJson(jsonString);

import 'dart:convert';

UpdateBoardResponse updateBoardResponseFromJson(String str) =>
    UpdateBoardResponse.fromJson(json.decode(str));

String updateBoardResponseToJson(UpdateBoardResponse data) =>
    json.encode(data.toJson());

class UpdateBoardResponse {
  String? message;

  UpdateBoardResponse({
    this.message,
  });

  factory UpdateBoardResponse.fromJson(Map<String, dynamic> json) =>
      UpdateBoardResponse(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
