// To parse this JSON data, do
//
//     final qrScanResponse = qrScanResponseFromJson(jsonString);

import 'dart:convert';

QrScanResponse qrScanResponseFromJson(String str) =>
    QrScanResponse.fromJson(json.decode(str));

String qrScanResponseToJson(QrScanResponse data) => json.encode(data.toJson());

class QrScanResponse {
  String? ssid;
  String? password;

  QrScanResponse({
    this.ssid,
    this.password,
  });

  factory QrScanResponse.fromJson(Map<String, dynamic> json) => QrScanResponse(
        ssid: json["ssid"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "ssid": ssid,
        "password": password,
      };
}
