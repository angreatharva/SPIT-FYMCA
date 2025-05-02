import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import '../models/blog_model.dart';
import 'api_service.dart';
import 'storage_service.dart';

class BlogService {
  static final BlogService _instance = BlogService._internal();
  factory BlogService() => _instance;
  BlogService._internal();

  static BlogService get instance => _instance;
  
  // Use ApiService's Dio instance for all calls
  final Dio _dio = ApiService.instance.client;

  // Get all blogs with pagination
  Future<Map<String, dynamic>> getAllBlogs({int page = 1, int limit = 10}) async {
    try {
      final response = await _dio.get(
        '/api/blogs',
        queryParameters: {'page': page, 'limit': limit},
      );

      if (response.statusCode == 200) {
        final List<dynamic> blogsJson = response.data['data'] ?? [];
        final List<BlogModel> blogs = blogsJson.map((json) => BlogModel.fromJson(json)).toList();
        
        return {
          'success': true,
          'blogs': blogs,
          'pagination': response.data['pagination'],
        };
      } else {
        throw Exception(response.data['message']);
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
      final response = await _dio.get('/api/blogs/$id');

      if (response.statusCode == 200) {
        final blog = BlogModel.fromJson(response.data['data']);
        
        return {
          'success': true,
          'blog': blog,
        };
      } else {
        throw Exception(response.data['message']);
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
        
        final response = await _dio.post(
          '/api/blogs',
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
        final response = await _dio.post(
          '/api/blogs',
          data: blog.toCreateJson(userId, createdByModel),
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
      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpeg'),
        ),
      });
      
      final response = await _dio.post(
        '/api/blogs/upload-image',
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
      
      final response = await _dio.get(
        '/api/blogs/user/$userId',
        queryParameters: {
          'userType': userType,
          'page': page,
          'limit': limit
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> blogsJson = response.data['data'] ?? [];
        final List<BlogModel> blogs = blogsJson.map((json) => BlogModel.fromJson(json)).toList();
        
        return {
          'success': true,
          'blogs': blogs,
          'pagination': response.data['pagination'],
        };
      } else {
        throw Exception(response.data['message']);
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
      
      final response = await _dio.delete(
        '/api/blogs/$blogId',
        data: {'userId': userId},
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': 'Blog deleted successfully',
        };
      } else {
        throw Exception(response.data['message']);
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