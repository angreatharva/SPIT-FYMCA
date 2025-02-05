import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: Get.height * 0.025,
          children: [
            Container(
              width: Get.width * 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(200)),
                    child: ClipOval(
                        child: Image.asset(
                      'assets/images/img.png',
                      height: Get.height * 0.25,
                      width: Get.height * 0.25,
                      fit: BoxFit.cover,
                    )),
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
            ),
            Container(
              child: Column(
                spacing: Get.height * 0.020,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: Get.width * 0.45,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          spacing: Get.width * 0.025,
                          children: [
                            Icon(
                              CupertinoIcons.cube_box,
                              color: Colors.grey.shade800,
                            ),
                            Text(
                              'Orders',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width * 0.45,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          spacing: Get.width * 0.025,
                          children: [
                            Icon(Icons.rocket_launch_outlined),
                            Text(
                              'Insider',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: Get.width * 0.45,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          spacing: Get.width * 0.025,
                          children: [
                            Icon(
                              Icons.headset_mic_outlined,
                              color: Colors.grey.shade800,
                            ),
                            Text(
                              'Help Center',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: Get.width * 0.45,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          spacing: Get.width * 0.025,
                          children: [
                            Icon(Icons.discount_outlined),
                            Text(
                              'Coupons',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                spacing: Get.height * 0.025,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.035),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Icon(CupertinoIcons.heart),
                      title: Text("Wishlist"),
                      subtitle: Text("Your most Loved Styles"),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.035),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.account_balance_wallet_outlined),
                      title: Text("Earn and Redeem"),
                      subtitle:
                          Text("Scan Coupons, view prizes and earn rewards"),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.035),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Icon(CupertinoIcons.settings),
                      title: Text("Account Settings"),
                      subtitle: Text("Manage your Account"),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.035),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.payments_outlined),
                      title: Text("Payment And Currencies"),
                      subtitle: Text("View Balance and save payment methods"),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: Get.width * 0.035),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.feedback_outlined),
                      title: Text("Feedback"),
                      subtitle: Text("Give your valuable reviews"),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
