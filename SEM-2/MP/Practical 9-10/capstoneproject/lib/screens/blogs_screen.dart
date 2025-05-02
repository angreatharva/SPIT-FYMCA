import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/blog_model.dart';
import '../services/blog_service.dart';
import '../services/storage_service.dart';
import '../utils/theme_constants.dart';
import '../widgets/blog_card.dart';
import '../widgets/custom_bottom_nav.dart';
import 'blog_detail_screen.dart';
import 'create_blog_screen.dart';

class BlogsScreen extends StatefulWidget {
  const BlogsScreen({Key? key}) : super(key: key);

  @override
  _BlogsScreenState createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  List<BlogModel> _blogs = [];
  Map<String, dynamic>? _pagination;
  bool _isLoading = false;
  bool _hasError = false;
  String? _errorMessage;
  bool _isMyBlogs = false;

  final ScrollController _scrollController = ScrollController();
  int _currentPage = 1;
  bool _hasMorePages = true;

  @override
  void initState() {
    super.initState();
    _fetchBlogs();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (_hasMorePages && !_isLoading) {
        _loadMoreBlogs();
      }
    }
  }

  Future<void> _fetchBlogs() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = null;
    });

    try {
      final response = _isMyBlogs
          ? await BlogService.instance.getBlogsByUser(page: 1, limit: 10)
          : await BlogService.instance.getAllBlogs(page: 1, limit: 10);

      setState(() {
        _isLoading = false;

        if (response['success']) {
          _blogs = response['blogs'];
          _pagination = response['pagination'];
          _hasMorePages = (_pagination?['page'] ?? 0) < (_pagination?['pages'] ?? 0);
          _currentPage = 1;
        } else {
          _hasError = true;
          _errorMessage = response['message'] ?? 'Failed to fetch blogs';
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
        _errorMessage = 'Error: $e';
      });
    }
  }

  Future<void> _loadMoreBlogs() async {
    if (_isLoading || !_hasMorePages) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final nextPage = _currentPage + 1;
      final response = _isMyBlogs
          ? await BlogService.instance.getBlogsByUser(page: nextPage, limit: 10)
          : await BlogService.instance.getAllBlogs(page: nextPage, limit: 10);

      setState(() {
        _isLoading = false;

        if (response['success']) {
          _blogs.addAll(response['blogs']);
          _pagination = response['pagination'];
          _hasMorePages = (_pagination?['page'] ?? 0) < (_pagination?['pages'] ?? 0);
          _currentPage = nextPage;
        } else {
          // Show error but keep existing blogs
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(response['message'] ?? 'Failed to load more blogs'),
              backgroundColor: Colors.red,
            ),
          );
        }
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error loading more blogs: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _refreshBlogs() async {
    _currentPage = 1;
    await _fetchBlogs();
  }

  void _toggleMyBlogs() {
    setState(() {
      _isMyBlogs = !_isMyBlogs;
    });
    _refreshBlogs();
  }

  void _openBlogDetail(BlogModel blog) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlogDetailScreen(
          blog: blog,
          onDelete: _refreshBlogs,
        ),
      ),
    );
  }

  Future<void> _createNewBlog() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const CreateBlogScreen()),
    );

    if (result == true) {
      _refreshBlogs();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = StorageService.instance.getUserData();
    final bool isLoggedIn = user != null;

    return Scaffold(
      backgroundColor: ThemeConstants.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeConstants.backgroundColor,
        toolbarHeight: Get.height * 0.08,
        title: Text(
          'Blogs',
          style: TextStyle(
            color: ThemeConstants.mainColor,
            fontSize: Get.width * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (isLoggedIn && user.isDoctor)
            TextButton.icon(
              onPressed: _toggleMyBlogs,
              icon: Icon(
                _isMyBlogs ? Icons.public : Icons.person,
                size: Get.width * 0.04,
                color: ThemeConstants.accentColor,
              ),
              label: Text(
                _isMyBlogs ? 'All Blogs' : 'My Blogs',
                style: TextStyle(
                  color: ThemeConstants.accentColor,
                  fontSize: Get.width * 0.035,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Description text - similar to Health Dashboard
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Health articles written by medical professionals',
                  style: TextStyle(
                    fontSize: Get.width * 0.04,
                    color: Colors.grey[700],
                  ),
                ),
                SizedBox(height: Get.height * 0.01),
              ],
            ),
          ),

          // Main content
          Expanded(
            child: _hasError
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: Get.width * 0.15,
                        ),
                        SizedBox(height: Get.height * 0.02),
                        Text(
                          _errorMessage ?? 'An error occurred',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: Get.width * 0.04,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: Get.height * 0.02),
                        ElevatedButton(
                          onPressed: _refreshBlogs,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2A7DE1),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: Get.width * 0.06, 
                              vertical: Get.height * 0.015
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Get.width * 0.06),
                            ),
                          ),
                          child: Text(
                            'Retry',
                            style: TextStyle(fontSize: Get.width * 0.04),
                          ),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: _refreshBlogs,
                    color: const Color(0xFF2A7DE1),
                    child: _blogs.isEmpty && !_isLoading
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.article,
                                  color: Color(0xFF2A7DE1),
                                  size: Get.width * 0.15,
                                ),
                                SizedBox(height: Get.height * 0.02),
                                Text(
                                  _isMyBlogs
                                      ? 'You haven\'t created any blogs yet'
                                      : 'No blogs available',
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: Get.width * 0.04,
                                  ),
                                ),
                                if (_isMyBlogs)
                                  Padding(
                                    padding: EdgeInsets.only(top: Get.height * 0.02),
                                    child: ElevatedButton(
                                      onPressed: _createNewBlog,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color(0xFF2A7DE1),
                                        foregroundColor: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                          horizontal: Get.width * 0.06, 
                                          vertical: Get.height * 0.015
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(Get.width * 0.06),
                                        ),
                                      ),
                                      child: Text(
                                        'Create Your First Blog',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Get.width * 0.04,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: _blogs.length + (_isLoading ? 1 : 0),
                            padding: EdgeInsets.only(bottom: Get.height * 0.1),
                            itemBuilder: (context, index) {
                              if (index == _blogs.length) {
                                return Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(Get.width * 0.02),
                                    child: CircularProgressIndicator(
                                      color: Color(0xFF2A7DE1),
                                    ),
                                  ),
                                );
                              }

                              final blog = _blogs[index];
                              final bool isBlogOwner = isLoggedIn && user.name == blog.authorName;

                              return BlogCard(
                                blog: blog,
                                isOwner: isBlogOwner,
                                onTap: () => _openBlogDetail(blog),
                                onDelete: isBlogOwner
                                    ? () async {
                                        final result = await showDialog<bool>(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text(
                                              'Delete Blog',
                                              style: TextStyle(fontSize: Get.width * 0.045),
                                            ),
                                            content: Text(
                                              'Are you sure you want to delete this blog?',
                                              style: TextStyle(fontSize: Get.width * 0.04),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(Get.width * 0.04),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, false),
                                                child: Text(
                                                  'Cancel',
                                                  style: TextStyle(fontSize: Get.width * 0.035),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(context, true),
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
                                              _refreshBlogs();
                                              if (mounted) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text('Blog deleted successfully'),
                                                    backgroundColor: Colors.green,
                                                  ),
                                                );
                                              }
                                            } else {
                                              if (mounted) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text(response['message'] ?? 'Failed to delete blog'),
                                                    backgroundColor: Colors.red,
                                                  ),
                                                );
                                              }
                                            }
                                          } catch (e) {
                                            if (mounted) {
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
                                    : null,
                              );
                            },
                          ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(),
      floatingActionButton: isLoggedIn && user.isDoctor
          ? FloatingActionButton(
              onPressed: _createNewBlog,
              backgroundColor: const Color(0xFF2A7DE1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Get.width * 0.06),
              ),
              child: Icon(
                Icons.add,
                size: Get.width * 0.06,
              ),
            )
          : null,
    );
  }
}