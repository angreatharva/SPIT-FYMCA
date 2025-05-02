import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/blog_model.dart';
import '../utils/theme_constants.dart';

class BlogCard extends StatelessWidget {
  final BlogModel blog;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  final bool isOwner;

  const BlogCard({
    Key? key,
    required this.blog,
    required this.onTap,
    this.onDelete,
    this.isOwner = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: Get.height * 0.01, 
        horizontal: Get.width * 0.04
      ),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Get.width * 0.06)),
      color: const Color(0XFFC3DEA9), // Light green color matching health tracking card
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(Get.width * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blog Image
            if (blog.imageUrl != null && blog.imageUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(Get.width * 0.06)),
                child: SizedBox(
                  height: Get.height * 0.19,
                  width: double.infinity,
                  child: Image.network(
                    blog.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: Get.height * 0.19,
                      width: double.infinity,
                      color: ThemeConstants.primaryColor.withOpacity(0.2),
                      child: Icon(
                        Icons.image_not_supported,
                        color: ThemeConstants.primaryColor,
                        size: Get.width * 0.125,
                      ),
                    ),
                  ),
                ),
              ),
            
            Padding(
              padding: EdgeInsets.all(Get.width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Delete Button
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          blog.title,
                          style: TextStyle(
                            fontSize: Get.width * 0.045,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isOwner && onDelete != null)
                        IconButton(
                          icon: Icon(
                            Icons.delete, 
                            color: Colors.red,
                            size: Get.width * 0.05,
                          ),
                          onPressed: onDelete,
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                        ),
                    ],
                  ),
                  
                  SizedBox(height: Get.height * 0.01),
                  
                  // Description
                  Text(
                    blog.description,
                    style: TextStyle(
                      fontSize: Get.width * 0.035,
                      color: Colors.grey.shade800,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  SizedBox(height: Get.height * 0.015),
                  
                  // Author and Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'By Dr. ${blog.authorName}',
                        style: TextStyle(
                          fontSize: Get.width * 0.03,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade800,
                        ),
                      ),
                      // Completed label style
                      Text(
                        _formatDate(blog.createdAt),
                        style: TextStyle(
                          fontSize: Get.width * 0.03,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                  
                  // Tags
                  if (blog.tags.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.01),
                      child: Wrap(
                        spacing: Get.width * 0.01,
                        runSpacing: Get.width * 0.01,
                        children: blog.tags.map((tag) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Get.width * 0.02, 
                            vertical: Get.height * 0.005
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(Get.width * 0.03),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              fontSize: Get.width * 0.025,
                              color: Colors.black87,
                            ),
                          ),
                        )).toList(),
                      ),
                    ),
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