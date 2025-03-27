import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/RestaurantMenuController.dart';

class CartScreen extends StatelessWidget {
  final RestaurantMenuController menuController = Get.find<RestaurantMenuController>();

  final double deliveryFee = 71.0;
  final double taxRate = 0.08;

  CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Obx(() {
        if (menuController.cart.isEmpty) {
          return const Center(
            child: Text('Your cart is empty'),
          );
        }

        double itemTotal = 0.0;
        menuController.cart.forEach((restaurantName, itemsMap) {
          (itemsMap as Map<String, int>).forEach((itemName, quantity) {
            var item = menuController.categories
                .expand((category) => category["items"] as List)
                .firstWhere(
                  (element) => element["name"] == itemName,
              orElse: () => null,
            );
            if (item != null) {
              itemTotal += (item["price"] * quantity);
            }
          });
        });

        double taxAndOtherCharges = itemTotal * taxRate;

        double tip = 0.0;

        double toPay = itemTotal + deliveryFee + taxAndOtherCharges + tip;

        return Column(
          children: [
            Expanded(
              child: ListView(
                children: menuController.cart.entries.map<Widget>((restaurantEntry) {
                  final restaurantName = restaurantEntry.key;
                  final itemsMap = restaurantEntry.value as Map<String, int>;

                  // Build a list of Widgets for each restaurant
                  List<Widget> listItems = [];

                  // Restaurant header
                  listItems.add(
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        restaurantName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );

                  // Each item in the restaurant
                  itemsMap.entries.forEach((entry) {
                    String itemName = entry.key;
                    int quantity = entry.value;

                    var item = menuController.categories
                        .expand((category) => category["items"] as List)
                        .firstWhere(
                          (element) => element["name"] == itemName,
                      orElse: () => null,
                    );

                    listItems.add(
                      ListTile(
                        leading: item != null
                            ? Image.asset(item["image"], width: 50, height: 50)
                            : null,
                        title: Text(itemName),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Quantity control
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: Colors.black),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () => menuController.removeFromCart(
                                      restaurantName,
                                      itemName,
                                    ),
                                    icon: const Icon(Icons.remove),
                                  ),
                                  Text("$quantity"),
                                  IconButton(
                                    onPressed: () => menuController.addToCart(
                                      restaurantName,
                                      itemName,
                                    ),
                                    icon: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "₹${quantity * (item?["price"] ?? 0)}",
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: listItems,
                  );
                }).toList(),
              ),
            ),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Colors.black12),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Bill Details",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Item Total"),
                      Text("₹${itemTotal.toStringAsFixed(2)}"),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Delivery Fee"),
                      Text("₹${deliveryFee.toStringAsFixed(2)}"),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Divider(thickness: 1),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Delivery Tip"),
                      GestureDetector(
                        onTap: () {

                        },
                        child: const Text(
                          "Add tip",
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("GST & Other Charges"),
                      Text("₹${taxAndOtherCharges.toStringAsFixed(2)}"),
                    ],
                  ),

                  const SizedBox(height: 8),
                  const Divider(thickness: 1),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "TO PAY",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "₹${toPay.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
