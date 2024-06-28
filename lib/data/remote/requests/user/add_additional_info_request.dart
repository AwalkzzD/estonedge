import 'dart:convert';

class AddAdditionalInfoRequest {
  String? contactNo;
  String? dob;
  String? gender;

  AddAdditionalInfoRequest({this.contactNo, this.dob, this.gender});

  String toRequestParams() => json.encode({
        "contact_no": contactNo ?? '',
        "dob": dob ?? '',
        "gender": gender ?? ''
      });
}
