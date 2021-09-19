//@dart=2.9
// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators

import 'dart:convert';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String authResponseToJson(AuthResponse data) => json.encode(data.toJson());

class AuthResponse {
  AuthResponse({
    this.message,
    this.response,
    this.token,
  });

  String message;
  Response response;
  String token;

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        message: json["message"] == null ? null : json["message"],
        response: json["response"] == null
            ? null
            : Response.fromJson(json["response"]),
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "response": response == null ? null : response.toJson(),
        "token": token == null ? null : token,
      };
}

class Response {
  Response(
      {this.foodItems,
      this.lat,
      this.lon,
      this.password,
      this.phoneNumber,
      this.storeName,
      this.type});

  List<String> foodItems;
  double lat;
  double lon;
  String password;
  String phoneNumber;
  String storeName;
  String type;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        foodItems: json["food-items"] == null
            ? null
            : List<String>.from(json["food-items"].map((x) => x)),
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lon: json["lon"] == null ? null : json["lon"].toDouble(),
        password: json["password"] == null ? null : json["password"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        storeName: json["store_name"] == null ? null : json["store_name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "food-items": foodItems == null
            ? null
            : List<dynamic>.from(foodItems.map((x) => x)),
        "lat": lat == null ? null : lat,
        "lon": lon == null ? null : lon,
        "password": password == null ? null : password,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "store_name": storeName == null ? null : storeName,
        "type": type
      };
}
