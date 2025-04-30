import 'package:flutter/material.dart';
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
        title: const Text('Delete Blog'),
        content: const Text('Are you sure you want to delete this blog?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          blog.title,
          style: const TextStyle(
            color: ThemeConstants.accentColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          if (isOwner)
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
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
              SizedBox(
                height: 200,
                width: double.infinity,
                child: Image.network(
                  blog.imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 200,
                    width: double.infinity,
                    color: ThemeConstants.primaryColor.withOpacity(0.2),
                    child: const Icon(
                      Icons.image_not_supported,
                      color: ThemeConstants.primaryColor,
                      size: 50,
                    ),
                  ),
                ),
              ),
            
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    blog.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: ThemeConstants.primaryColor,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Author and date
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        size: 16,
                        color: ThemeConstants.accentColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        blog.authorName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ThemeConstants.accentColor,
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatDate(blog.createdAt),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  
                  // Tags
                  if (blog.tags.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: blog.tags.map((tag) => Chip(
                          label: Text(tag),
                          backgroundColor: ThemeConstants.primaryColor.withOpacity(0.2),
                        )).toList(),
                      ),
                    ),
                  
                  const Divider(),
                  
                  // Description
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      blog.description,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Content
                  Text(
                    blog.content,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
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