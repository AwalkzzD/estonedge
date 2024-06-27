import 'dart:convert';

import 'package:estonedge/data/remote/model/user/user_response.dart';

AdditionalInfoResponse additionalInfoResponseFromJson(String str) =>
    AdditionalInfoResponse.fromJson(json.decode(str));

String additionalInfoResponseToJson(AdditionalInfoResponse data) =>
    json.encode(data.toJson());

class AdditionalInfoResponse {
  final AdditionalInfo additionalInfo;

  AdditionalInfoResponse({
    required this.additionalInfo,
  });

  factory AdditionalInfoResponse.fromJson(Map<String, dynamic> json) {
    return AdditionalInfoResponse(
      additionalInfo:
          AdditionalInfo.fromJson(json["additional_info"]?["M"] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "additional_info": {"M": additionalInfo.toJson()},
    };
  }
}
