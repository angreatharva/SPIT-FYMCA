import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/blog_model.dart';
import '../services/blog_service.dart';
import '../services/storage_service.dart';
import '../utils/theme_constants.dart';

class BlogDetailScreen extends StatelessWidget {
  final BlogModel blog;
  final Function? onDelete;

  const BlogDetailScreen({
    Key? key,
    required this.blog,
    this.onDelete,
  }) : super(key: key);

  bool get isOwner {
    final user = StorageService.instance.getUserData();
    if (user == null || blog.id == null) return false;
    
    // Check if the current user is the creator of the blog
    // This would require additional fields in the blog model to check properly
    // Here we're just checking if the author name matches the user name
    return blog.authorName == user.name;
  }

  Future<void> _confirmDelete(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Blog',
          style: TextStyle(
            fontSize: Get.width * 0.045,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to delete this blog?',
          style: TextStyle(fontSize: Get.width * 0.04),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Get.width * 0.06),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(fontSize: Get.width * 0.035),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(
              'Delete',
              style: TextStyle(
                color: Colors.red,
                fontSize: Get.width * 0.035,
              ),
            ),
          ),
        ],
      ),
    );

    if (result == true && blog.id != null) {
      try {
        final response = await BlogService.instance.deleteBlog(blog.id!);
        
        if (response['success']) {
          if (onDelete != null) {
            onDelete!();
          }
          
          // Pop back to the previous screen
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Blog deleted successfully'),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.of(context).pop();
          }
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(response['message'] ?? 'Failed to delete blog'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeConstants.backgroundColor,
        toolbarHeight: Get.height * 0.08,
        title: Text(
          'Blog Details',
          style: TextStyle(
            color: ThemeConstants.mainColor,
            fontSize: Get.width * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (isOwner)
            IconButton(
              icon: Icon(
                Icons.delete, 
                color: Colors.red,
                size: Get.width * 0.06,
              ),
              onPressed: () => _confirmDelete(context),
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blog image
            if (blog.imageUrl != null && blog.imageUrl!.isNotEmpty)
              Container(
                height: Get.height * 0.25,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Get.width * 0.06),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Get.width * 0.06),
                  child: Image.network(
                    blog.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: Get.height * 0.25,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0XFFC3DEA9),
                        borderRadius: BorderRadius.circular(Get.width * 0.06),
                      ),
                      child: Icon(
                        Icons.image_not_supported,
                        color: Colors.white,
                        size: Get.width * 0.125,
                      ),
                    ),
                  ),
                ),
              ),
            
            Padding(
              padding: EdgeInsets.all(Get.width * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    blog.title,
                    style: TextStyle(
                      fontSize: Get.width * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF284C1C),
                    ),
                  ),
                  
                  SizedBox(height: Get.height * 0.02),
                  
                  // Author and date
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.04, 
                      vertical: Get.height * 0.015
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(Get.width * 0.04),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: Get.width * 0.04,
                          color: Color(0xFF284C1C),
                        ),
                        SizedBox(width: Get.width * 0.02),
                        Text(
                          'Dr. ${blog.authorName}',
                          style: TextStyle(
                            fontSize: Get.width * 0.035,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF284C1C),
                          ),
                        ),
                        SizedBox(width: Get.width * 0.04),
                        Icon(
                          Icons.calendar_today,
                          size: Get.width * 0.04,
                          color: Colors.grey,
                        ),
                        SizedBox(width: Get.width * 0.02),
                        Text(
                          _formatDate(blog.createdAt),
                          style: TextStyle(
                            fontSize: Get.width * 0.035,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Tags
                  if (blog.tags.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                      child: Wrap(
                        spacing: Get.width * 0.02,
                        runSpacing: Get.width * 0.02,
                        children: blog.tags.map((tag) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.03, 
                            vertical: Get.height * 0.008
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0XFFC3DEA9),
                            borderRadius: BorderRadius.circular(Get.width * 0.04),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: Get.width * 0.03,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
                  
                  SizedBox(height: Get.height * 0.02),
                  
                  // Description - styled like a card
                  Container(
                    padding: EdgeInsets.all(Get.width * 0.04),
                    decoration: BoxDecoration(
                      color: const Color(0XFFC3DEA9),
                      borderRadius: BorderRadius.circular(Get.width * 0.06),
                    ),
                    child: Text(
                      blog.description,
                      style: TextStyle(
                        fontSize: Get.width * 0.04,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: Get.height * 0.03),
                  
                  // Content
                  Container(
                    padding: EdgeInsets.all(Get.width * 0.04),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(Get.width * 0.06),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Text(
                      blog.content,
                      style: TextStyle(
                        fontSize: Get.width * 0.04,
                        height: 1.5,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  
                  SizedBox(height: Get.height * 0.05),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return '';
    }
  }
} 