//@dart=2.9
import 'dart:convert';

import 'package:food_track/feeds_page.dart';
import 'package:food_track/models/auth_response.dart';
import 'package:food_track/models/food_details.dart';
import 'package:food_track/models/food_list.dart';
import 'package:food_track/models/inventory_response.dart';
import 'package:food_track/models/login_request.dart';
import 'package:food_track/models/near_by_store.dart';
import 'package:food_track/models/register_request.dart';
import 'package:food_track/models/result_response.dart';
import 'package:food_track/models/searchedfood_response.dart';
import 'package:food_track/models/textrecognition_response.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

class ApiManager {
  static var client = http.Client();
  //static var cache = CacheManager().cache();
  Future<ResultResponse<AuthResponse, String>> sRegister(
      SellerRegisterRequest request) async {
    var result = AuthResponse();
    var message = "";
    try {
      var response = await client.post(Uri.parse(Urls.register),
          body: sellerRegisterRequestToJson(request));
      result = authResponseFromJson(response.body);
      message = result.message;
    } catch (e) {
      message = "Network Error";
    }
    return ResultResponse(result, message);
  }

  Future<ResultResponse<AuthResponse, String>> login(
      LoginRequest request) async {
    var result = AuthResponse();
    var message = "";
    try {
      var response = await client.post(Uri.parse(Urls.login), body: {
        "phone_number": request.phonenumber,
        "password": request.password,
        "type": request.type
      });
      result = authResponseFromJson(response.body);
      message = result.message;
      // cache.storeCred(
      //     result.response.phoneNumber, result.response.type, result.token);
    } catch (e) {
      print(e);
      message = "Network Error";
    }
    return ResultResponse(result, message);
  }

  Future<ResultResponse<SearchedResponse, String>> searchFood(
      String food, double lat, double lon) async {
    var result = SearchedResponse();
    var message = "";
    try {
      final url = Urls.getsearchedfood + "?food=$food&lat=$lat&lon=$lon";
      var response = await client.get(Uri.parse(url),
          headers: {'authorization': "Ettm3Ld6wCThSROEpS7tcp1Da6m2"});
      result = searchedResponseFromJson(response.body);
      message = "success";
    } catch (e) {
      message = "Network Error";
    }
    return ResultResponse(result, message);
  }

  Future<ResultResponse<NearByStoreResponse, String>> nearByStore(
      double lat, double lon) async {
    var result = NearByStoreResponse();
    var message = "";
    try {
      final url = Urls.nearbystore + "?lat=$lat&lon=$lon";
      var response = await client.get(Uri.parse(url),
          headers: {'authorization': "Ettm3Ld6wCThSROEpS7tcp1Da6m2"});
      result = nearByStoreResponeFromJson(response.body);
      print(response.body.toString());
      message = "success";
    } catch (e) {
      print(e);
      message = "Network Error";
    }
    return ResultResponse(result, message);
  }

  Future<ResultResponse<InventoryResponse, String>> getInventory() async {
    var result = InventoryResponse();
    var message = "";
    try {
      final url =
          "${Urls.getinventory}?authorization=Ettm3Ld6wCThSROEpS7tcp1Da6m2";
      var response = await client.get(Uri.parse(url));
      result = inventoryResponseFromJson(response.body);
      message = "success";
    } catch (e) {
      print(e.toString());
      message = "Network Error";
    }
    return ResultResponse(result, message);
  }

  Future<void> textRecognition(String img64) async {
    var result = TextRecognitionResponse();
    var message = "";
    try {
      final url = Urls.textrecognition;
      var payload = {
        "base64Image": "data:image/jpg;base64,${img64.toString()}"
      };
      var header = {"apikey": "eeef9fc4c888957"};
      var response =
          await http.post(Uri.parse(url), body: payload, headers: header);
      result = textRecognitionResponseFromJson(response.body);
      for (var res in result.parsedResults) {
        print(res.parsedText);
      }
      message = "success";
    } catch (e) {
      print(e.toString());
      message = "Network Error";
    }
  }

  Future<ResultResponse<FoodListResponse, String>> getfoodList(
      List<String> list) async {
    var result = FoodListResponse();
    var message = "";
    try {
      var url = Urls.getfoodlist;
      url = url + "?";
      for (int i = 0; i < list.length; ++i) {
        url += 'list=' + list[i];
        if (i < list.length - 1) url += '&';
      }
      print(url);
      print("getting");
      var response = await client.get(Uri.parse(url),
          headers: {"authorization": "Ettm3Ld6wCThSROEpS7tcp1Da6m2"});
      result = foodListResponseFromJson(response.body);
      print(response.body);
      print(result);
      print("got");
      message = "success";
    } catch (e) {
      print("exception" + e);
      message = "Network Error";
    }
    return ResultResponse(result, message);
  }

  Future<ResultResponse<FoodDetailResponse, String>> admin(
      String lat, String lon, String rad) async {
    var result = FoodDetailResponse();
    var message = "";
    try {
      var url = Urls.admin + "?" + "lat=$lat&lon=$lon&rad=$rad";
      print("getting");
      var response = await client.get(Uri.parse(url),
          headers: {"authorization": "Ettm3Ld6wCThSROEpS7tcp1Da6m2"});
      result = foodDetailsResponseFromJson(response.body);
      print(response.body);
      print(result);
      print("got");
      message = "success";
    } catch (e) {
      print("exception" + e);
      message = "Network Error";
    }
    return ResultResponse(result, message);
  }
}
