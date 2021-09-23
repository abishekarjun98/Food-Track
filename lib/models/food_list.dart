//@dart=2.9

import 'dart:convert';

FoodListResponse foodListResponseFromJson(String str) =>
    FoodListResponse.fromJson(json.decode(str));

String foodListResponseToJson(FoodListResponse data) =>
    json.encode(data.toJson());

class FoodListResponse {
  FoodListResponse({
    this.response,
  });

  List<Response> response;

  factory FoodListResponse.fromJson(Map<String, dynamic> json) =>
      FoodListResponse(
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
    this.food,
  });

  Food food;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        food: json["food"] == null ? null : Food.fromJson(json["food"]),
      );

  Map<String, dynamic> toJson() => {
        "food": food == null ? null : food.toJson(),
      };
}

class Food {
  Food({
    this.nutritions,
    this.price,
    this.name,
    this.quantity,
    this.imageUrl,
  });

  Map<String, String> nutritions;
  String price;
  String name;
  String quantity;
  String imageUrl;

  factory Food.fromJson(Map<String, dynamic> json) => Food(
        nutritions:
            json["nutritions"] == null ? null : jsonDecode(json["nutritions"]),
        price: json["price"] == null ? null : json["price"],
        name: json["name"] == null ? null : json["name"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        imageUrl: json["image_url"] == null ? null : json["image_url"],
      );

  Map<String, dynamic> toJson() => {
        "nutritions": nutritions == null ? null : jsonEncode(nutritions),
        "price": price == null ? null : price,
        "name": name == null ? null : name,
        "quantity": quantity == null ? null : quantity,
        "image_url": imageUrl == null ? null : imageUrl,
      };
}
