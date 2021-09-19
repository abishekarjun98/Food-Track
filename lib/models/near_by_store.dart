//@dart=2.9
import 'dart:convert';

NearByStoreResponse nearByStoreResponseFromJson(String str) =>
    NearByStoreResponse.fromJson(json.decode(str));

String nearByStoreResponseToJson(NearByStoreResponse data) =>
    json.encode(data.toJson());

class NearByStoreResponse {
  NearByStoreResponse({
    this.respone,
  });

  List<Respone> respone;

  factory NearByStoreResponse.fromJson(Map<String, dynamic> json) =>
      NearByStoreResponse(
        respone: json["respone"] == null
            ? null
            : List<Respone>.from(
                json["respone"].map((x) => Respone.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "respone": respone == null
            ? null
            : List<dynamic>.from(respone.map((x) => x.toJson())),
      };
}

class Respone {
  Respone({
    this.foodItems,
    this.lat,
    this.lon,
    this.password,
    this.phoneNumber,
    this.storeName,
  });

  List<String> foodItems;
  double lat;
  double lon;
  String password;
  String phoneNumber;
  String storeName;

  factory Respone.fromJson(Map<String, dynamic> json) => Respone(
        foodItems: json["food-items"] == null
            ? null
            : List<String>.from(json["food-items"].map((x) => x)),
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lon: json["lon"] == null ? null : json["lon"].toDouble(),
        password: json["password"] == null ? null : json["password"],
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        storeName: json["store_name"] == null ? null : json["store_name"],
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
      };
}
