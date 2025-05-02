const express = require('express');
const router = express.Router();
const blogController = require('../controllers/blog.controller');
const upload = require('../middleware/upload.middleware');
const { verifyToken } = require('../middleware/auth.middleware');

// Create a new blog (with possible image upload)
router.post('/', verifyToken, upload, blogController.createBlog);

// Upload a blog image
router.post('/upload-image', verifyToken, upload, blogController.uploadBlogImage);

// Get all blogs with pagination
router.get('/', verifyToken, blogController.getAllBlogs);

// Get blogs by user (patient or doctor)
router.get('/user/:userId', verifyToken, blogController.getBlogsByUser);

// Get a single blog by ID
router.get('/:id', verifyToken, blogController.getBlogById);

// Update a blog (with possible image upload)
router.put('/:id', verifyToken, upload, blogController.updateBlog);

// Delete a blog
router.delete('/:id', verifyToken, blogController.deleteBlog);

module.exports = router; 