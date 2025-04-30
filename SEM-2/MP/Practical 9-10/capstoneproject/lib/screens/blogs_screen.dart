import 'package:flutter/material.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Blogs',
          style: TextStyle(
            color: ThemeConstants.accentColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          if (isLoggedIn)
            TextButton.icon(
              onPressed: _toggleMyBlogs,
              icon: Icon(
                _isMyBlogs ? Icons.public : Icons.person,
                size: 16,
                color: ThemeConstants.accentColor,
              ),
              label: Text(
                _isMyBlogs ? 'All Blogs' : 'My Blogs',
                style: const TextStyle(color: ThemeConstants.accentColor),
              ),
            ),
        ],
      ),
      body: _hasError
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _errorMessage ?? 'An error occurred',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refreshBlogs,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            )
          : RefreshIndicator(
              onRefresh: _refreshBlogs,
              child: _blogs.isEmpty && !_isLoading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.article,
                            color: ThemeConstants.primaryColor,
                            size: 60,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _isMyBlogs
                                ? 'You haven\'t created any blogs yet'
                                : 'No blogs available',
                            style: TextStyle(color: Colors.grey.shade700),
                          ),
                          if (_isMyBlogs)
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: ElevatedButton(
                                onPressed: _createNewBlog,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ThemeConstants.primaryColor,
                                ),
                                child: const Text(
                                  'Create Your First Blog',
                                  style: TextStyle(color: Colors.white),
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
                      padding: const EdgeInsets.only(bottom: 80),
                      itemBuilder: (context, index) {
                        if (index == _blogs.length) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: CircularProgressIndicator(),
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
                                      title: const Text('Delete Blog'),
                                      content: const Text('Are you sure you want to delete this blog?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, false),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(context, true),
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
      bottomNavigationBar: const CustomBottomNav(),
      floatingActionButton: isLoggedIn
          ? FloatingActionButton(
              onPressed: _createNewBlog,
              backgroundColor: ThemeConstants.accentColor,
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
}