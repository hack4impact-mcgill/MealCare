import 'dart:convert';
import 'package:frontend/models/food.dart';
import 'package:http/http.dart' as http;

class HttpClientService {
  static final mainServer = 'http://127.0.0.1:8000';

  final addFoodApi = mainServer + '/add_food';

  /**
   * create food items.
   *
   * @param Food
   * @returns integer statusCode
   * @memberof HttpClientService
   */ 
  Future<int> createFood(Food food) async {
    final response =
        await http.post(this.addFoodApi, body: json.encode(food.toJson()));
    return response.statusCode;
  }
}
