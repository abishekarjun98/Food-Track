//@dart=2.9

import 'dart:convert';

FoodListResponse foodListResponseFromJson(String str) =>
    FoodListResponse.fromJson(json.decode(str));

String foodListResponseToJson(FoodListResponse data) =>
    json.encode(data.toJson());

class FoodListResponse {
  FoodListResponse({
    this.message,
    this.response,
  });

  String message;
  List<Response> response;

  factory FoodListResponse.fromJson(Map<String, dynamic> json) =>
      FoodListResponse(
        message: json["message"] == null ? null : json["message"],
        response: json["response"] == null
            ? null
            : List<Response>.from(
                json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "response": response == null
            ? null
            : List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class Response {
  Response({
    this.foods,
  });

  Foods foods;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        foods: json["foods"] == null ? null : Foods.fromJson(json["foods"]),
      );

  Map<String, dynamic> toJson() => {
        "foods": foods == null ? null : foods.toJson(),
      };
}

class Foods {
  Foods(
      {this.imageUrl,
      this.name,
      this.nutritions,
      this.price,
      this.quantity,
      this.isSelected});

  String imageUrl;
  String name;
  List<Nutritions> nutritions;
  String price;
  String quantity;
  bool isSelected = false;

  factory Foods.fromJson(Map<String, dynamic> json) => Foods(
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        name: json["name"] == null ? null : json["name"],
        nutritions: json["nutritions"] == null
            ? null
            : getNutritions(json['nutritions'] as Map<String, dynamic>),
        price: json["price"] == null ? null : json["price"],
        quantity: json["quantity"] == null ? null : json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl == null ? null : imageUrl,
        "name": name == null ? null : name,
        "nutritions": nutritions == null ? null : nutritions,
        "price": price == null ? null : price,
        "quantity": quantity == null ? null : quantity,
      };

  static List<Nutritions> getNutritions(Map<String, dynamic> map) {
    List<Nutritions> list = List<Nutritions>.empty(growable: true);
    map.entries.forEach((element) {
      Nutritions nutri =
          Nutritions(name: element.key, gram: element.value as String);
      list.add(nutri);
    });
    return list;
  }
}

class Nutritions {
  Nutritions({
    this.name,
    this.gram,
  });

  String name;
  String gram;
}
