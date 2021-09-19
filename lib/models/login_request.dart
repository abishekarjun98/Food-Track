//@dart=2.9
import 'dart:convert';

LoginRequest loginRequestromJson(String str) =>
    LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  LoginRequest({this.phonenumber, this.password, this.type});

  String phonenumber;
  String password;
  String type;

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
        phonenumber: json["phone_number"],
        password: json["password"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phonenumber,
        "password": password,
        "type": type,
      };
}
