import 'dart:convert';
import 'package:frontend/models/food.dart';
import 'package:frontend/models/foodCollect.dart';
import 'package:frontend/models/vendor.dart';
import 'package:frontend/models/tray.dart';
import 'package:http/http.dart' as http;

class HttpException implements Exception {
  String message;
  int statusCode;

  HttpException(this.message, this.statusCode);
}

class HttpClientService {
  static final mainServer = 'http://127.0.0.1:8000';

  final addFoodEndPoint = (foodCollectId) => mainServer + '/add_food/$foodCollectId';
  final addVendorsEndPoint = mainServer + '/add_vendor';
  final addFoodCollectEndPoint = mainServer + '/add_food_collect';
  final addTrayEndPoint = (vendorId, foodCollectId) => mainServer + '/vendors/$vendorId/$foodCollectId /add_tray';
  final addTrayCollectEndPoint = mainServer + '/add_tray_collect';
  final addTrayReturnEndPoint = mainServer + '/add_tray_return';

  final getAllFoodEndPoint = mainServer + '/food/';
  final getAllVendorsEndPoint = mainServer + '/vendors';
  final getAllFoodCollectEndPoint =  mainServer + '/get_all_food_collect/';

  final getFoodCollectEndPoint = (foodCollectId) => mainServer + '/get_food_collect/$foodCollectId';
  final getVendorEndpoint = (vendorId) => mainServer + '/vendors/$vendorId';

  final deleteFoodEndPoint = (foodId) => mainServer + '/remove_food/$foodId';
  final deleteVendorEndPoint = (vendorId) => mainServer + '/vendors/$vendorId';
  final deleteFoodCollectEndPoint = (foodCollectId) => mainServer + '/remove_food_collect/$foodCollectId';

  final updateFoodCollectEndPoint = mainServer + '/update_food_collect';
  
  /*
   * create food item.
   *
   * @param Food
   * @returns integer statusCode
   * @memberof HttpClientService
   */
  Future<int> addFood(Food food, int foodCollectId) async {
    final response = await http.post(this.addFoodEndPoint(foodCollectId),
        body: json.encode(food.toJson()));

    if (response.statusCode == 200) {
      return response.statusCode;
    }

    throw new HttpException(response.body, response.statusCode);
  }

  /*
   * delete food item.
   *
   * @param FoodId
   * @returns integer statusCode
   * @memberof HttpClientService
   */
  Future<int> deleteFood(int foodId) async {
    final response = await http.delete(this.deleteFoodEndPoint(foodId));

    if (response.statusCode == 200) {
      return response.statusCode;
    }

    throw new HttpException(response.body, response.statusCode);
  }

  /*
   * get all food.
   *
   * @param void
   * @returns all food
   * @memberof HttpClientService
   */
  Future<List<Food>> getAllFood() async {
    final response = await http.get(this.getAllFoodEndPoint);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var allFood = jsonData.map((food) => Food.fromJson(food)).toList();

      return allFood;
    }

    throw new HttpException(response.body, response.statusCode);
  }

  /*
   * add foodCollect items.
   *
   * @param foodCollect
   * @returns integer statusCode
   * @memberof HttpClientService
   */
  Future<int> addFoodCollect(FoodCollect foodCollect) async {
    final response = await http.post(this.addFoodCollectEndPoint, body: json.encode(foodCollect.toJson()));

    if (response.statusCode == 200) {
      return response.statusCode;
    }

    throw new HttpException(response.body, response.statusCode);
  }

  /*
   * get foodCollect item.
   *
   * @param foodCollectId
   * @returns FoodCollect item or null
   * @memberof HttpClientService
   */
  Future<FoodCollect> getFoodCollect(int foodCollectId) async {
    final response = await http.get(this.getFoodCollectEndPoint(foodCollectId));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var foodCollect = jsonData.map((food) => Food.fromJson(food)).toList();

      return (foodCollect == null || foodCollect.isEmpty)
          ? HttpException("There is no foodCollect with this id.", response.statusCode)
          : foodCollect.first;
    }

    throw new HttpException(response.body, response.statusCode);
  }

/*
   * get all foodCollect.
   *
   * @param void
   * @returns all foodCollect
   * @memberof HttpClientService
   */
  Future<List<FoodCollect>> getAllFoodCollect() async {
    final response = await http.get(this.getAllFoodCollectEndPoint);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var allFoodCollect = jsonData.map((foodCollect) => FoodCollect.fromJson(foodCollect)).toList();

      return allFoodCollect;
    }

    throw new HttpException(response.body, response.statusCode);
  }
  /*
   * delete foodCollect item.
   *
   * @param foodCollectId
   * @returns integer statusCode
   * @memberof HttpClientService
   */
  Future<int> deleteFoodCollect(int foodCollectId) async {
    final response =
        await http.delete(this.deleteFoodCollectEndPoint(foodCollectId));

    if (response.statusCode == 200) {
      return response.statusCode;
    }

    throw new HttpException(response.body, response.statusCode);
  }

  /*
   * Update foodCollect items.
   *
   * @param foodCollect
   * @returns integer statusCode
   * @memberof HttpClientService
   */
  Future<int> updateFoodCollect(FoodCollect foodCollect) async {
    final response = await http.put(this.updateFoodCollectEndPoint, body: json.encode(foodCollect.toJson()));

    if (response.statusCode == 200) {
      return response.statusCode;
    }

    throw new HttpException(response.body, response.statusCode);
  }

  /*
   * create tray.
   *
   * @param Tray
   * @returns integer statusCode
   * @memberof HttpClientService
   */
  Future<int> addTray(Tray tray, int vendorId, int foodCollectId) async {
    final response = await http.post(this.addTrayEndPoint(vendorId, foodCollectId),
        body: json.encode(tray.toJson()));

    if (response.statusCode == 200) {
      return response.statusCode;
    }

    throw new HttpException(response.body, response.statusCode);
  }

  /*
   * create trayCollect.
   *
   * @param tray
   * @returns integer statusCode
   * @memberof HttpClientService
   */
  Future<int> addTrayCollect(Tray tray) async {
    final response =
        await http.post(this.addTrayCollectEndPoint, body: json.encode(tray.toJson()));

    return response.statusCode;
  }

  /*
   * create trayReturn.
   *
   * @param tray
   * @returns integer statusCode
   * @memberof HttpClientService
   */
  Future<int> addTrayRetrun(Tray tray) async {
    final response =
        await http.post(this.addTrayReturnEndPoint, body: json.encode(tray.toJson()));

    return response.statusCode;
  }

  /*
   * create vendor.
   *
   * @param Vendor
   * @returns integer statusCode
   * @memberof HttpClientService
   */
  Future<int> createVendor(Vendor vendor) async {
    final response =
        await http.post(this.addVendorsEndPoint, body: json.encode(vendor.toJson()));

    return response.statusCode;
  }

  /*
   * get all vendors.
   *
   * @param void
   * @returns List of Vendor
   * @memberof HttpClientService
   */
  Future<List<Vendor>> getAllVendors() async {
    final response = await http.get(this.getAllVendorsEndPoint);

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var vendors = jsonData.map((vendor) => Vendor.fromJson(vendor)).toList();

      return vendors;
    }

    throw new HttpException(response.body, response.statusCode);
  }

  /*
   * delete Vendor.
   *
   * @param vendorId
   * @returns integer StatusCode
   * @memberof HttpClientService
   */
  Future<int> deleteVendor(int vendorId) async {
    final response =
        await http.delete(this.deleteVendorEndPoint(vendorId));

    if (response.statusCode == 200) {
      return response.statusCode;
    }

    throw new HttpException(response.body, response.statusCode);
  }

   /*
   * Get Vendor by id 
   *
   * @param vendorId 
   * @returns vendor item or null
   * @memberof HttpClientService
   */
  Future<Vendor> getVendor(int vendorId) async {
    final response = await http.get(this.getVendorEndpoint(vendorId));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var vendor = jsonData.map((vendor) => Vendor.fromJson(vendor)).toList();

      return (vendor == null || vendor.isEmpty)
          ? HttpException("There is no vendor with this id.", response.statusCode)
          : vendor.first;
    }

    throw new HttpException(response.body, response.statusCode);
  }
}
