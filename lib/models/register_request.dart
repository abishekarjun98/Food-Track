//@dart=2.9
import 'dart:convert';

SellerRegisterRequest sellerRegisterRequestFromJson(String str) =>
    SellerRegisterRequest.fromJson(json.decode(str));

String sellerRegisterRequestToJson(SellerRegisterRequest data) =>
    json.encode(data.toJson());

class SellerRegisterRequest {
  SellerRegisterRequest({
    this.phonenumber,
    this.password,
    this.lat,
    this.lon,
    this.storename,
    this.foodItems,
    this.type,
  });

  List<String> foodItems;
  double lat;
  double lon;
  String password;
  String phonenumber;
  String storename;
  String type;

  factory SellerRegisterRequest.fromJson(Map<String, dynamic> json) =>
      SellerRegisterRequest(
        foodItems: json["food-items"] == null
            ? null
            : List<String>.from(json["food-items"].map((x) => x)),
        lat: json["lat"] == 0 ? null : json["lat"].toDouble(),
        lon: json["lon"] == 0 ? null : json["lon"].toDouble(),
        password: json["password"] == "NONE" ? null : json["password"],
        phonenumber:
            json["phone_number"] == "NONE" ? null : json["phone_number"],
        storename: json["store_name"] == "NONE" ? null : json["store_name"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "phone_number": phonenumber,
        "password": password,
        "lat": lat,
        "lon": lon,
        "store_name": storename,
        "food_items": foodItems,
        "type": type,
      };
}
