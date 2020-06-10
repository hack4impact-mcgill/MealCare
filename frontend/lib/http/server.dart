import 'dart:convert';
import 'package:frontend/models/food.dart';
import 'package:frontend/models/vendor.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class HttpClientService {
  static final mainServer = 'http://127.0.0.1:8000';

  final addFoodApi = mainServer + '/add_food';
  final getAllFoodCollectApi = mainServer + '/get_all_food_collect';
  final getVendorsApi = mainServer + '/vendors';

  /// create food items.
  /// @param Food
  /// @returns integer statusCode
  /// @memberof HttpClientService
  Future<int> createFood(Food food) async {
    final response =
        await http.post(this.addFoodApi, body: json.encode(food.toJson()));
    return response.statusCode;
  }

  Future<Response> getFoodCollect() async {
    final response =
        await http.get('http://127.0.0.1:8000/get_all_food_collect');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return response;
    } else {
      // If that call was not successful, throw an error.
      print(response.statusCode);
      throw Exception('Failed to load post');
    }
  }

  Future<List<Vendor>> getAllVendors() async {
    final response = await http.get(this.getVendorsApi);

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      var jsonData = json.decode(response.body);
      List<Vendor> vendors = [];
      for (var u in jsonData) {
        Vendor ven = Vendor.fromJson(u);
        vendors.add(ven);
      }
      print(vendors.length);
      return vendors;
    } else {
      // If that call was not successful, throw an error.
      print(response.statusCode);
      throw Exception('Failed to load post');
    }
  }
}
