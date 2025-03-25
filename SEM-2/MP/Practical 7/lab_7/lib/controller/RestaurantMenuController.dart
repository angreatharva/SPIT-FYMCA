import 'package:get/get.dart';

class RestaurantMenuController extends GetxController {
  // Menu data for the current restaurant
  var categories = [
    {
      "title": "Recommended",
      "items": [
        {
          "name": "Tea",
          "price": 30,
          "rating": 4.8,
          "image": "assets/images/tea.png"
        },
      ]
    },
    {
      "title": "Snacks",
      "items": []
    },
    {
      "title": "Meals - Indian Veg",
      "items": [
        {
          "name": "Paneer Bhurji",
          "price": 355,
          "rating": 4.5,
          "image": "assets/images/panneerbhurji.png"
        },
      ]
    }
  ].obs;

  // Cart data structure: { "restaurantName": { "itemName": quantity } }
  var cart = {}.obs;

  void addToCart(String restaurantName, String itemName) {
    if (cart.containsKey(restaurantName)) {
      Map<String, int> items = cart[restaurantName];
      if (items.containsKey(itemName)) {
        items[itemName] = items[itemName]! + 1;
      } else {
        items[itemName] = 1;
      }
      cart[restaurantName] = items;
    } else {
      cart[restaurantName] = {itemName: 1};
    }
  }

  void removeFromCart(String restaurantName, String itemName) {
    if (cart.containsKey(restaurantName)) {
      Map<String, int> items = cart[restaurantName];
      if (items.containsKey(itemName) && items[itemName]! > 0) {
        items[itemName] = items[itemName]! - 1;
        if (items[itemName] == 0) {
          items.remove(itemName);
        }
      }
      if (items.isEmpty) {
        cart.remove(restaurantName);
      } else {
        cart[restaurantName] = items;
      }
    }
  }

  int getItemCount(String restaurantName, String itemName) {
    if (cart.containsKey(restaurantName)) {
      Map<String, int> items = cart[restaurantName];
      return items[itemName] ?? 0;
    }
    return 0;
  }
}
