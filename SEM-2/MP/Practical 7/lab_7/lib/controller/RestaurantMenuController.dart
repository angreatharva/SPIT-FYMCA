import 'package:get/get.dart';

class RestaurantMenuController extends GetxController {
  var categories = [
    {
      "title": "Recommended",
      "items": [
        {"name": "Tea", "price": 30, "rating": 4.8, "image": "assets/images/tea.png"},
      ]
    },
    {
      "title": "Snacks",
      "items": []
    },
    {
      "title": "Meals - Indian Veg",
      "items": [
        {"name": "Paneer Bhurji", "price": 355, "rating": 4.5, "image": "assets/images/panneerbhurji.png"},
      ]
    }
  ].obs;
}
