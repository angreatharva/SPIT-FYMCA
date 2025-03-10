import 'package:get/get.dart';
import 'package:lab_7/Screens/restaurantDetailScreen.dart';
import 'Screens/cart_screen.dart';
import 'Screens/homeScreen.dart';
import 'Screens/restaurant_details.dart';


class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const HomeScreen()),
    GetPage(name: '/cart', page: () => const CartScreen()),
    GetPage(name: '/restaurant', page: () => const RestaurantScreen()),
    GetPage(name: '/restaurantDetail', page: () => RestaurantDetailScreen()),
  ];
}