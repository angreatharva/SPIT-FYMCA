import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/RestaurantMenuController.dart';

class RestaurantDetailScreen extends StatelessWidget {
  final RestaurantMenuController menuController =
      Get.put(RestaurantMenuController());

  @override
  Widget build(BuildContext context) {
    // Retrieve restaurant details from arguments
    final Map<String, dynamic> restaurant =
        Get.arguments?.cast<String, dynamic>() ?? {};

    return Scaffold(
      appBar: AppBar(title: const Text("Restaurant Menu")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      restaurant['name'] ?? 'Restaurant Name',
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
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Specialities: ${restaurant['speciality'] ?? 'N/A'}",
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // // Search bar
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: TextField(
              //     decoration: InputDecoration(
              //       hintText: "Search for dishes",
              //       prefixIcon: const Icon(Icons.search),
              //       border: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(10),
              //       ),
              //     ),
              //   ),
              // ),

              Center(
                  child: Text(
                "Menu",
                style: TextStyle(fontSize: 25),
              )),

              // Menu List
              Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: menuController.categories.length,
                  itemBuilder: (context, index) {
                    var category = menuController.categories[index];
                    var items = (category['items'] as List?) ??
                        []; // Ensure items is always a list

                    return ExpansionTile(
                      title: Text("${category['title']} (${items.length})",
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      children: items.map<Widget>((item) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Checkbox (if needed)
                              Icon(Icons.indeterminate_check_box_outlined,
                                  color: Colors.green),

                              // Food Name and Price
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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

                              // Food Image with Rounded Corners
                              Stack(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    item["image"],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                Positioned(
                                  top:50,
                                  left:5,
                                  child: ElevatedButton(
                                    onPressed: () {}, // Add to cart functionality
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text("ADD",
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ]),


                            ],
                          ),
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
    );
  }
}
