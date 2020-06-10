import 'package:flutter/material.dart';
import 'package:frontend/pages/food_item_page.dart';

import 'models/vendor.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    if (settings.name == '/foodItemPage') {
      if (args is Vendor) {
        return MaterialPageRoute(
            builder: (_) => FoodItemPage(
                  data: args,
                ));
      }
    }
  }
}
