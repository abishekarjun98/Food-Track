//@dart=2.9
import 'package:food_track/cache/cache_manager.dart';
import 'package:food_track/models/auth_response.dart';
import 'package:food_track/models/inventory_response.dart';
import 'package:food_track/models/login_request.dart';
import 'package:food_track/models/near_by_store.dart';
import 'package:food_track/models/register_request.dart';
import 'package:food_track/models/result_response.dart';
import 'package:food_track/models/searchedfood_response.dart';
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
      var response = await client.post(Uri.parse(Urls.login),
          body: loginRequestToJson(request));
      result = authResponseFromJson(response.body);
      message = result.message;
      // cache.storeCred(
      //     result.response.phoneNumber, result.response.type, result.token);
    } catch (e) {
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
      result = nearByStoreResponseFromJson(response.body);
      message = "success";
    } catch (e) {
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
}
