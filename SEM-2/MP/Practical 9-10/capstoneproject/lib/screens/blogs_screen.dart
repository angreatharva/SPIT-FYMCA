import 'package:flutter/material.dart';
import '../utils/theme_constants.dart';
import '../widgets/custom_bottom_nav.dart';

class BlogsScreen extends StatelessWidget {
  const BlogsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Blogs',
            style: TextStyle(
              color: ThemeConstants.accentColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          )
      ),
      body: const Center(child: Text('Blogs Content')),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}