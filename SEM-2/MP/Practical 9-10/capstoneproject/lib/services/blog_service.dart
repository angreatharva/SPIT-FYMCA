import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../models/blog_model.dart';
import 'api_service.dart';
import 'storage_service.dart';

class BlogService {
  static final BlogService _instance = BlogService._internal();
  factory BlogService() => _instance;
  BlogService._internal();

  static BlogService get instance => _instance;

  // Get all blogs with pagination
  Future<Map<String, dynamic>> getAllBlogs({int page = 1, int limit = 10}) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/api/blogs?page=$page&limit=$limit'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> blogsJson = jsonResponse['data'] ?? [];
        final List<BlogModel> blogs = blogsJson.map((json) => BlogModel.fromJson(json)).toList();
        
        return {
          'success': true,
          'blogs': blogs,
          'pagination': jsonResponse['pagination'],
        };
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      debugPrint('Error fetching blogs: $e');
      return {
        'success': false,
        'message': 'Failed to fetch blogs: $e',
      };
    }
  }

  // Get a single blog by ID
  Future<Map<String, dynamic>> getBlogById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/api/blogs/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final blog = BlogModel.fromJson(jsonResponse['data']);
        
        return {
          'success': true,
          'blog': blog,
        };
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      debugPrint('Error fetching blog: $e');
      return {
        'success': false,
        'message': 'Failed to fetch blog: $e',
      };
    }
  }

  // Create a new blog
  Future<Map<String, dynamic>> createBlog(BlogModel blog, {File? imageFile}) async {
    try {
      final user = StorageService.instance.getUserData();
      if (user == null) {
        return {
          'success': false,
          'message': 'User not logged in',
        };
      }

      final userId = user.id;
      final createdByModel = user.isDoctor ? 'Doctor' : 'User';
      
      if (imageFile != null) {
        // Upload with image file
        final dio = Dio();
        
        FormData formData = FormData.fromMap({
          'title': blog.title,
          'description': blog.description,
          'content': blog.content,
          'tags': blog.tags.join(','),
          'userId': userId,
          'createdByModel': createdByModel,
          'image': await MultipartFile.fromFile(
            imageFile.path,
            contentType: MediaType('image', 'jpeg'),
          ),
        });
        
        final response = await dio.post(
          '${ApiService.baseUrl}/api/blogs',
          data: formData,
        );
        
        if (response.statusCode == 201) {
          final blog = BlogModel.fromJson(response.data['data']);
          return {
            'success': true,
            'message': 'Blog created successfully',
            'blog': blog,
          };
        } else {
          throw Exception(response.data['message']);
        }
      } else {
        // Upload without image
        final response = await http.post(
          Uri.parse('${ApiService.baseUrl}/api/blogs'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(blog.toCreateJson(userId, createdByModel)),
        );

        if (response.statusCode == 201) {
          final jsonResponse = jsonDecode(response.body);
          final blog = BlogModel.fromJson(jsonResponse['data']);
          
          return {
            'success': true,
            'message': 'Blog created successfully',
            'blog': blog,
          };
        } else {
          throw Exception(jsonDecode(response.body)['message']);
        }
      }
    } catch (e) {
      debugPrint('Error creating blog: $e');
      return {
        'success': false,
        'message': 'Failed to create blog: $e',
      };
    }
  }

  // Upload a blog image
  Future<Map<String, dynamic>> uploadBlogImage(File imageFile) async {
    try {
      final dio = Dio();
      
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      });
      
      final response = await dio.post(
        '${ApiService.baseUrl}/api/blogs/upload-image',
        data: formData,
      );
      
      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Image uploaded successfully',
          'imageUrl': response.data['data']['imageUrl'],
        };
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e) {
      debugPrint('Error uploading image: $e');
      return {
        'success': false,
        'message': 'Failed to upload image: $e',
      };
    }
  }

  // Get blogs by user
  Future<Map<String, dynamic>> getBlogsByUser({int page = 1, int limit = 10}) async {
    try {
      final user = StorageService.instance.getUserData();
      if (user == null) {
        return {
          'success': false,
          'message': 'User not logged in',
        };
      }

      final userId = user.id;
      final userType = user.isDoctor ? 'Doctor' : 'User';
      
      final response = await http.get(
        Uri.parse('${ApiService.baseUrl}/api/blogs/user/$userId?userType=$userType&page=$page&limit=$limit'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> blogsJson = jsonResponse['data'] ?? [];
        final List<BlogModel> blogs = blogsJson.map((json) => BlogModel.fromJson(json)).toList();
        
        return {
          'success': true,
          'blogs': blogs,
          'pagination': jsonResponse['pagination'],
        };
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      debugPrint('Error fetching user blogs: $e');
      return {
        'success': false,
        'message': 'Failed to fetch user blogs: $e',
      };
    }
  }

  // Delete a blog
  Future<Map<String, dynamic>> deleteBlog(String blogId) async {
    try {
      final user = StorageService.instance.getUserData();
      if (user == null) {
        return {
          'success': false,
          'message': 'User not logged in',
        };
      }

      final userId = user.id;
      
      final response = await http.delete(
        Uri.parse('${ApiService.baseUrl}/api/blogs/$blogId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'userId': userId}),
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Blog deleted successfully',
        };
      } else {
        throw Exception(jsonDecode(response.body)['message']);
      }
    } catch (e) {
      debugPrint('Error deleting blog: $e');
      return {
        'success': false,
        'message': 'Failed to delete blog: $e',
      };
    }
  }
} 