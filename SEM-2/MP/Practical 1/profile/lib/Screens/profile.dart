import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (!await launchUrl(url)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not launch $urlString')),
        );
      }
    } catch (e) {
      debugPrint('Error launching $urlString: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to open $urlString')),
      );
    }
  }

  String about =
      "MCA student at Sardar Patel Institute of Technology with expertise in Flutter, full-stack, and backend development, focusing on scalable systems and new technologies.";

  String CIM =
      "The Colliers CRM app simplifies property management with real-time search, dashboards, detailed pages, and multilingual support for iOS and Android.";

  String WMS =
      "The Warehouse Management System optimizes inventory with modules for Putaway, Picking, Packing, and more, ensuring efficient tracking and storage.";

  String SAS =
      "The RFID-based attendance system automates tracking with Google Sheets and Firebase, offering admin tools and student access to attendance details.";

  String ach1 = "Ranked 3rd in Khelo India University Games 2023 for Mallakhamb. National player with accolades in state and national competitions.";
  String ach2 = "Performed Mallakhamb internationally in Australia, Budapest, Mexico, and Bahrain, promoting this traditional Indian sport globally.";

  final List<Map<String, String>> imageItems = [
    {'imagePath': 'assets/images/1.jpeg', 'title': 'Acrobatic Dynamic'},
    {'imagePath': 'assets/images/2.jpeg', 'title': 'MoonKnight'},
    {'imagePath': 'assets/images/3.jpeg', 'title': 'CWG 2018'},
    {'imagePath': 'assets/images/4.jpeg', 'title': 'CWG 2018'},
    {'imagePath': 'assets/images/5.jpeg', 'title': 'CWG 2018'},
    {'imagePath': 'assets/images/6.jpg', 'title': 'Khelo India 2023'},
  ];
  final CarouselController controller = CarouselController(initialItem: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          title: Text("Profile"),
        ),
        body: CustomScrollView(slivers: [
          SliverAppBar(
            expandedHeight: Get.height * 0.4,
            pinned: true,
            backgroundColor: Colors.white, // Set background color to white
            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                // Calculate the progress of the collapse (0.0 to 1.0)
                final progress = 1.0 -
                    (constraints.maxHeight - constraints.minHeight) /
                        (Get.height * 0.4 - kToolbarHeight);

                // Ensure progress is between 0 and 1
                final safeProgress = math.max(0.0, math.min(1.0, progress));

                return FlexibleSpaceBar(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (safeProgress > 0.5)
                        Text(
                          "Atharva Vasant Angre",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                  background: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/images/profileImage.png',
                          height: Get.height * 0.25,
                          width: Get.height * 0.25,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        "Atharva Vasant Angre",
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              SizedBox(height: Get.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // GitHub
                  GestureDetector(
                    onTap: () => _launchURL('https://github.com/angreatharva'),
                    child: Container(
                      height: Get.height * 0.08,
                      width: Get.width * 0.2,
                      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.025,vertical: Get.height * 0.005),
                      decoration: BoxDecoration(
                        color: Color(0xffffd146),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Colors.black, width: 2.5),
                      ),
                      child: Image.asset(
                        'assets/images/git1.png',
                        height: Get.height * 0.050,
                      ),
                    ),
                  ),

                  // Email
                  GestureDetector(
                    onTap: () => _launchURL(
                        'mailto:angreatharva08@gmail.com?subject=Greetings&body=Hello Atharva,'),
                    child: Container(
                      height: Get.height * 0.08,
                      width: Get.width * 0.2,
                      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.025,vertical: Get.height * 0.005),
                      decoration: BoxDecoration(
                        color: Color(0xffffd146),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Colors.black, width: 2.5),
                      ),
                      child: Icon(Icons.mail_outline_rounded, size: 60),
                    ),
                  ),

                  // LinkedIn
                  GestureDetector(
                    onTap: () => _launchURL(
                        'https://www.linkedin.com/in/atharva-angre-3146aa269/'),
                    child: Container(
                      height: Get.height * 0.08,
                      width: Get.width * 0.2,
                      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.025,vertical: Get.height * 0.005),
                      decoration: BoxDecoration(
                        color: Color(0xffffd146),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Colors.black, width: 2.5),
                      ),
                      child: Image.asset(
                        'assets/images/linkedIn.png',
                        height: Get.height * 0.05,
                      ),
                    ),
                  ),

                  // Phone
                  GestureDetector(
                    onTap: () => _launchURL('tel:+919167449720'),
                    child: Container(
                      height: Get.height * 0.08,
                      width: Get.width * 0.2,
                      padding: EdgeInsets.symmetric(horizontal: Get.width * 0.025,vertical: Get.height * 0.005),
                      decoration: BoxDecoration(
                        color: Color(0xffffd146),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        border: Border.all(color: Colors.black, width: 2.5),
                      ),
                      child: Icon(Icons.phone_android_rounded, size: 50),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Get.height * 0.02),
              Column(
                spacing: Get.height * 0.02,
                children: [
                  Container(
                    width: Get.width * 0.95,
                    // height: Get.height * 0.35,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.black, width: 2.5),
                      color: Color(0xffbed5ea),
                    ),
                    child: Text(
                      about,
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                  ),
                  Container(
                    width: Get.width * 0.95,
                    height: Get.height * 0.35,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.black, width: 2.5),
                      color: Color(0xffbed5ea),
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        // physics: ,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: Get.height * 0.015,
                          children: [
                            Text(
                              "Project",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 25),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "ReConnect",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20),
                                ),
                                Text(
                                  CIM,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "WMS",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18),
                                ),
                                Text(
                                  WMS,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Smart Attendance System",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18),
                                ),
                                Text(
                                  SAS,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width * 0.95,
                    // height: Get.height * 0.38,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.black, width: 2.5),
                      color: Color(0xffbed5ea),
                    ),
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Achievements",
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 25),
                            ),
                            Text(
                              "\u2022 "+ach1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                            Text(
                              "\u2022 "+ach2,
                              style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: Get.width * 0.95,
                    height: Get.height * 0.35,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.black, width: 2.5),
                      color: Color(0xffbed5ea),
                    ),
                    child: CarouselView.weighted(
                      controller: controller,
                      itemSnapping: true,
                      flexWeights: const <int>[1,7,1],
                      children: imageItems.map((Map<String, String> item) {
                        return HeroLayoutCard(
                          imagePath: item['imagePath']!,
                          title: item['title']!,
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: Get.height * 0.005)
                ],
              )
            ],
          ))
        ]));
  }
}
class HeroLayoutCard extends StatelessWidget {
  const HeroLayoutCard({
    Key? key,
    required this.imagePath,
    required this.title,
  }) : super(key: key);

  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Color(0xff1e1818),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
