//@dart=2.9
import 'dart:convert';

InventoryResponse inventoryResponseFromJson(String str) =>
    InventoryResponse.fromJson(json.decode(str));

String inventoryResponseToJson(InventoryResponse data) =>
    json.encode(data.toJson());

class InventoryResponse {
  InventoryResponse({
    this.message,
    this.response,
  });

  String message;
  List<Response> response;

  factory InventoryResponse.fromJson(Map<String, dynamic> json) =>
      InventoryResponse(
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
    this.imageUrl,
    this.name,
    this.quantity,
  });

  String imageUrl;
  String name;
  String quantity;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        imageUrl: json["image_url"] == null ? null : json["image_url"],
        name: json["name"] == null ? null : json["name"],
        quantity: json["quantity"] == null ? null : json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "image_url": imageUrl == null ? null : imageUrl,
        "name": name == null ? null : name,
        "quantity": quantity == null ? null : quantity,
      };
}
