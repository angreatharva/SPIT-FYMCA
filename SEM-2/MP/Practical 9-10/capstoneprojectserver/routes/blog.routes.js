const express = require('express');
const router = express.Router();
const blogController = require('../controllers/blog.controller');
const upload = require('../middleware/upload.middleware');

// Create a new blog (with possible image upload)
router.post('/', upload, blogController.createBlog);

// Upload a blog image
router.post('/upload-image', upload, blogController.uploadBlogImage);

// Get all blogs with pagination
router.get('/', blogController.getAllBlogs);

// Get blogs by user (patient or doctor)
router.get('/user/:userId', blogController.getBlogsByUser);

// Get a single blog by ID
router.get('/:id', blogController.getBlogById);

// Update a blog (with possible image upload)
router.put('/:id', upload, blogController.updateBlog);

// Delete a blog
router.delete('/:id', blogController.deleteBlog);

module.exports = router; 