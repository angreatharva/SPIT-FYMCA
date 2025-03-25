import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/RestaurantMenuController.dart';

class RestaurantDetailScreen extends StatelessWidget {
  // Retrieve the global controller instance.
  final RestaurantMenuController menuController = Get.find<RestaurantMenuController>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> restaurant =
        Get.arguments?.cast<String, dynamic>() ?? {};
    final String restaurantName = restaurant['name'] ?? 'Restaurant Name';

    return Scaffold(
      appBar: AppBar(title: const Text("Restaurant Menu")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Restaurant Image and Gradient overlay
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                child: Stack(
                  children: [
                    Image.asset(
                      restaurant['image']!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 24,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(1),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Restaurant Details
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurantName,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.green),
                        Text(
                          restaurant['rating'] ?? 'N/A',
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black87),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Estimated Delivery Time: ${restaurant['time'] ?? 'N/A'}",
                      style: const TextStyle(
                          fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Specialities: ${restaurant['speciality'] ?? 'N/A'}",
                      style: const TextStyle(
                          fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  "Menu",
                  style: TextStyle(fontSize: 25),
                ),
              ),
              // Menu List
              Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: menuController.categories.length,
                  itemBuilder: (context, index) {
                    var category = menuController.categories[index];
                    var items = (category['items'] as List?) ?? [];
                    return ExpansionTile(
                      title: Text(
                        "${category['title']} (${items.length})",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      children: items.map<Widget>((item) {
                        return Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  // Icon (if needed)
                                  Icon(Icons.indeterminate_check_box_outlined,
                                      color: Colors.green),
                                  // Food Name and Price
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item["name"],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                        Text(
                                          "₹${item["price"]}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Food Image
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      item["image"],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Add to Cart UI (always shows "-" and "+" buttons)
                            Positioned(
                              top: 90,
                              left: 328,
                              child: Obx(() {
                                int itemCount = menuController.getItemCount(
                                    restaurantName, item["name"]);
                                return Container(
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.green,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (itemCount > 0) {
                                            menuController.removeFromCart(
                                                restaurantName, item["name"]);
                                            Get.snackbar("Item Removed Successfully",
                                                "",
                                                snackPosition:
                                                SnackPosition.BOTTOM,
                                                backgroundColor: Colors.red);
                                          }
                                        },
                                        child: const Text(
                                          "-",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          itemCount == 0 ? "Add" : "$itemCount",
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          menuController.addToCart(
                                              restaurantName, item["name"]);
                                          Get.snackbar("Item Added Successfully", "",
                                              snackPosition: SnackPosition.BOTTOM,
                                              backgroundColor: Colors.green);
                                        },
                                        child: const Text(
                                          "+",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ],
                        );
                      }).toList(),
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/cart');
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}
