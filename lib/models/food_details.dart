//@dart=2.9
import 'dart:convert';

FoodDetailResponse foodDetailsResponseFromJson(String str) =>
    FoodDetailResponse.fromJson(json.decode(str));

String foodDetailsResponseToJson(FoodDetailResponse data) =>
    json.encode(data.toJson());

class FoodDetailResponse {
  FoodDetailResponse({
    this.response,
  });

  Response response;

  factory FoodDetailResponse.fromJson(Map<String, dynamic> json) =>
      FoodDetailResponse(
        response: json["response"] == null
            ? null
            : Response.fromJson(json["response"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response == null ? null : response.toJson(),
      };
}

class Response {
  Response({
    this.imageUrl,
    this.name,
    this.nutritions,
    this.price,
    this.quantity,
  });

  String imageUrl;
  String name;
  List<Nutritions> nutritions;
  String price;
  String quantity;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
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
