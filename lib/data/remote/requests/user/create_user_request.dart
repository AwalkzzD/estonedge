import 'dart:convert';

class CreateUserRequestParameters {
  String? name;
  String? email;

  CreateUserRequestParameters({this.name, this.email});

  String toRequestParams() => json.encode({"name": name, "email": email});
}
