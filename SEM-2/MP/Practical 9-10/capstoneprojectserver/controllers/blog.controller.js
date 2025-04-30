const Blog = require('../models/blog.model');
const User = require('../models/user.model');
const Doctor = require('../models/doctor.model');
const path = require('path');
const fs = require('fs');

/**
 * Create a new blog
 */
exports.createBlog = async (req, res) => {
  try {
    const { title, description, content, tags, createdByModel } = req.body;
    const userId = req.body.userId;
    
    // Validate required fields
    if (!title || !description || !content || !userId || !createdByModel) {
      return res.status(400).json({
        success: false,
        message: 'Missing required fields'
      });
    }
    
    // Check if the user/doctor exists
    let creator;
    let authorName;
    
    if (createdByModel === 'User') {
      creator = await User.findById(userId);
      if (!creator) {
        return res.status(404).json({
          success: false,
          message: 'User not found'
        });
      }
      authorName = creator.userName;
    } else if (createdByModel === 'Doctor') {
      creator = await Doctor.findById(userId);
      if (!creator) {
        return res.status(404).json({
          success: false,
          message: 'Doctor not found'
        });
      }
      authorName = creator.doctorName;
    } else {
      return res.status(400).json({
        success: false,
        message: 'Invalid creator model type'
      });
    }
    
    // Handle image if present
    let imageUrl = null;
    if (req.file) {
      // If there's a file uploaded, set the imageUrl
      imageUrl = `${req.protocol}://${req.get('host')}/uploads/${req.file.filename}`;
    } else if (req.body.imageUrl) {
      // If imageUrl is provided as a text field
      imageUrl = req.body.imageUrl;
    }
    
    // Create the blog
    const blog = new Blog({
      authorName,
      title,
      description,
      content,
      tags: tags || [],
      createdBy: userId,
      createdByModel,
      imageUrl
    });
    
    await blog.save();
    
    res.status(201).json({
      success: true,
      message: 'Blog created successfully',
      data: blog
    });
  } catch (error) {
    console.error('Error creating blog:', error);
    res.status(500).json({
      success: false,
      message: 'An error occurred while creating the blog',
      error: error.message
    });
  }
};

/**
 * Get all blogs with pagination
 */
exports.getAllBlogs = async (req, res) => {
  try {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const skip = (page - 1) * limit;
    
    const blogs = await Blog.find()
      .sort({ createdAt: -1 })
      .skip(skip)
      .limit(limit);
    
    const total = await Blog.countDocuments();
    
    res.status(200).json({
      success: true,
      data: blogs,
      pagination: {
        total,
        page,
        pages: Math.ceil(total / limit)
      }
    });
  } catch (error) {
    console.error('Error fetching blogs:', error);
    res.status(500).json({
      success: false,
      message: 'An error occurred while fetching blogs',
      error: error.message
    });
  }
};

/**
 * Get a single blog by ID
 */
exports.getBlogById = async (req, res) => {
  try {
    const blog = await Blog.findById(req.params.id);
    
    if (!blog) {
      return res.status(404).json({
        success: false,
        message: 'Blog not found'
      });
    }
    
    res.status(200).json({
      success: true,
      data: blog
    });
  } catch (error) {
    console.error('Error fetching blog:', error);
    res.status(500).json({
      success: false,
      message: 'An error occurred while fetching the blog',
      error: error.message
    });
  }
};

/**
 * Update a blog
 */
exports.updateBlog = async (req, res) => {
  try {
    const { title, description, content, tags } = req.body;
    
    // Find the blog
    const blog = await Blog.findById(req.params.id);
    
    if (!blog) {
      return res.status(404).json({
        success: false,
        message: 'Blog not found'
      });
    }
    
    // Check if the user is the creator of the blog
    if (blog.createdBy.toString() !== req.body.userId) {
      return res.status(403).json({
        success: false,
        message: 'Unauthorized: You can only update your own blogs'
      });
    }
    
    // Handle image if present
    let imageUrl = blog.imageUrl;
    if (req.file) {
      // If there's a file uploaded, set the imageUrl
      imageUrl = `${req.protocol}://${req.get('host')}/uploads/${req.file.filename}`;
      
      // Delete old image if it exists and is not the default image
      if (blog.imageUrl && !blog.imageUrl.includes('default-blog-image')) {
        const oldImagePath = blog.imageUrl.split('/uploads/')[1];
        if (oldImagePath) {
          const fullPath = path.join(__dirname, '../uploads', oldImagePath);
          if (fs.existsSync(fullPath)) {
            fs.unlinkSync(fullPath);
          }
        }
      }
    } else if (req.body.imageUrl !== undefined) {
      // If imageUrl is provided as a text field
      imageUrl = req.body.imageUrl;
    }
    
    // Update fields
    if (title) blog.title = title;
    if (description) blog.description = description;
    if (content) blog.content = content;
    if (tags) blog.tags = tags;
    blog.imageUrl = imageUrl;
    
    await blog.save();
    
    res.status(200).json({
      success: true,
      message: 'Blog updated successfully',
      data: blog
    });
  } catch (error) {
    console.error('Error updating blog:', error);
    res.status(500).json({
      success: false,
      message: 'An error occurred while updating the blog',
      error: error.message
    });
  }
};

/**
 * Delete a blog
 */
exports.deleteBlog = async (req, res) => {
  try {
    // Find the blog
    const blog = await Blog.findById(req.params.id);
    
    if (!blog) {
      return res.status(404).json({
        success: false,
        message: 'Blog not found'
      });
    }
    
    // Check if the user is the creator of the blog
    if (blog.createdBy.toString() !== req.body.userId) {
      return res.status(403).json({
        success: false,
        message: 'Unauthorized: You can only delete your own blogs'
      });
    }
    
    // Delete the blog image if it exists and is not the default image
    if (blog.imageUrl && !blog.imageUrl.includes('default-blog-image')) {
      const imagePath = blog.imageUrl.split('/uploads/')[1];
      if (imagePath) {
        const fullPath = path.join(__dirname, '../uploads', imagePath);
        if (fs.existsSync(fullPath)) {
          fs.unlinkSync(fullPath);
        }
      }
    }
    
    await Blog.findByIdAndDelete(req.params.id);
    
    res.status(200).json({
      success: true,
      message: 'Blog deleted successfully'
    });
  } catch (error) {
    console.error('Error deleting blog:', error);
    res.status(500).json({
      success: false,
      message: 'An error occurred while deleting the blog',
      error: error.message
    });
  }
};

/**
 * Get blogs by user (patient or doctor)
 */
exports.getBlogsByUser = async (req, res) => {
  try {
    const userId = req.params.userId;
    const userType = req.query.userType || 'User'; // Default to User if not specified
    
    if (!['User', 'Doctor'].includes(userType)) {
      return res.status(400).json({
        success: false,
        message: 'Invalid user type. Must be User or Doctor'
      });
    }
    
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const skip = (page - 1) * limit;
    
    const blogs = await Blog.find({
      createdBy: userId,
      createdByModel: userType
    })
      .sort({ createdAt: -1 })
      .skip(skip)
      .limit(limit);
    
    const total = await Blog.countDocuments({
      createdBy: userId,
      createdByModel: userType
    });
    
    res.status(200).json({
      success: true,
      data: blogs,
      pagination: {
        total,
        page,
        pages: Math.ceil(total / limit)
      }
    });
  } catch (error) {
    console.error('Error fetching user blogs:', error);
    res.status(500).json({
      success: false,
      message: 'An error occurred while fetching user blogs',
      error: error.message
    });
  }
};

/**
 * Upload a blog image
 */
exports.uploadBlogImage = async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({
        success: false,
        message: 'No image file provided'
      });
    }
    
    const imageUrl = `${req.protocol}://${req.get('host')}/uploads/${req.file.filename}`;
    
    res.status(200).json({
      success: true,
      message: 'Image uploaded successfully',
      data: { imageUrl }
    });
  } catch (error) {
    console.error('Error uploading image:', error);
    res.status(500).json({
      success: false,
      message: 'An error occurred while uploading image',
      error: error.message
    });
  }
}; 