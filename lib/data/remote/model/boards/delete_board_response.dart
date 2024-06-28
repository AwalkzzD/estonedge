// To parse this JSON data, do
//
//     final deleteBoardResponse = deleteBoardResponseFromJson(jsonString);

import 'dart:convert';

DeleteBoardResponse deleteBoardResponseFromJson(String str) =>
    DeleteBoardResponse.fromJson(json.decode(str));

String deleteBoardResponseToJson(DeleteBoardResponse data) =>
    json.encode(data.toJson());

class DeleteBoardResponse {
  String? message;

  DeleteBoardResponse({
    this.message,
  });

  factory DeleteBoardResponse.fromJson(Map<String, dynamic> json) =>
      DeleteBoardResponse(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
