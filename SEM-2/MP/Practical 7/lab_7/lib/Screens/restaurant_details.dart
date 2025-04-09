import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> restaurants = [
      {
        "name": "Pizza Hut",
        "rating": "4.3",
        "time": "45-50 mins",
        "image": "assets/images/pizzahut.png",
        "speciality": "Pizzas",

      },
      {
        "name": "Urban Cafe",
        "rating": "4.7",
        "time": "50-55 mins",
        "image": "assets/images/urbancafe.png",
        "speciality": "Snacks, Pizzas, Pastas, Fast Food, Burgers, Cafe",

      },
      {
        "name": "Shree Naivedyam",
        "rating": "4.5",
        "time": "45-50 mins",
        "image": "assets/images/shri.png",
        "speciality": "North Indian, Chinese, South Indian, Pizzas, Beverages",
      },{
        "name": "Jai Ganesh Bhojnalaya",
        "rating": "4.5",
        "time": "35-40 mins",
        "image": "assets/images/ganesh.png",
        "speciality": "North Indian, South Indian, Indian, Chinese",
      },{
        "name": "Hotel Sai Nath & Sai Restaurant",
        "rating": "4.3",
        "time": "35-40 mins",
        "image": "assets/images/sai.png",
        "speciality": "North Indian, South Indian, Chinese, Beverages, Fast Food, Desserts",
      },{
        "name": "Bharat Mewad Ice Cream",
        "rating": "4.4",
        "time": "35-40 mins",
        "image": "assets/images/mewad.png",
        "speciality": "Ice Cream, Desserts, Beverages",
      },{
        "name": "Apni Rasoi Family Dhaba",
        "rating": "4.2",
        "time": "45-50 mins",
        "image": "assets/images/rasoi.png",
        "speciality": "North Indian, Indian, South Indian, Chinese",
      },{
        "name": "The Fusion Lounge",
        "rating": "4.1",
        "time": "50-55 mins",
        "image": "assets/images/fusion.png",
        "speciality": "South Indian, Chinese, Beverages, Fast Food, Desserts",
      },{
        "name": "Satkar Restaurant",
        "rating": "4.5",
        "time": "25-30 mins",
        "image": "assets/images/satkar.png",
        "speciality": "North Indian, South Indian, Indian, Salads, Desserts",
      },
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate using GetX
                Get.toNamed('/restaurantDetail', arguments: restaurants[index]);
              },
              child: Card(
                color: AppTheme.accentColor,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  height: Get.height * 0.3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                          child: Stack(
                            children: [
                              Image.asset(
                                restaurants[index]['image']!,
                                width: double.infinity,
                                height: 120,
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
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              restaurants[index]['name']!,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(Icons.stars, color: Colors.green),
                                Text(
                                  '${restaurants[index]['rating']} - ${restaurants[index]['time']}',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                            Text(
                              restaurants[index]['speciality']!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[600],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
