//@dart=2.9
import 'dart:convert';

SearchedResponse searchedResponseFromJson(String str) =>
    SearchedResponse.fromJson(json.decode(str));

String searchedResponseToJson(SearchedResponse data) =>
    json.encode(data.toJson());

class SearchedResponse {
  SearchedResponse({
    this.response,
  });

  List<Response> response;

  factory SearchedResponse.fromJson(Map<String, dynamic> json) =>
      SearchedResponse(
        response: json["response"] == null
            ? null
            : List<Response>.from(
                json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": response == null
            ? null
            : List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class Response {
  Response({
    this.details,
    this.distance,
  });

  Details details;
  double distance;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "details": details == null ? null : details.toJson(),
        "distance": distance == null ? null : distance,
      };
}

class Details {
  Details({
    this.foodItems,
    this.lat,
    this.lon,
    this.phoneNumber,
    this.storeName,
  });

  List<String> foodItems;
  double lat;
  double lon;
  String phoneNumber;
  String storeName;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        foodItems: json["food-items"] == null
            ? null
            : List<String>.from(json["food-items"].map((x) => x)),
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lon: json["lon"] == null ? null : json["lon"].toDouble(),
        phoneNumber: json["phone_number"] == null ? null : json["phone_number"],
        storeName: json["store_name"] == null ? null : json["store_name"],
      );

  Map<String, dynamic> toJson() => {
        "food-items": foodItems == null
            ? null
            : List<dynamic>.from(foodItems.map((x) => x)),
        "lat": lat == null ? null : lat,
        "lon": lon == null ? null : lon,
        "phone_number": phoneNumber == null ? null : phoneNumber,
        "store_name": storeName == null ? null : storeName,
      };
}
