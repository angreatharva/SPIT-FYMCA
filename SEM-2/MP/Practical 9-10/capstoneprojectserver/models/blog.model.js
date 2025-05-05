const mongoose = require('mongoose');

/**
 * @swagger
 * components:
 *   schemas:
 *     Blog:
 *       type: object
 *       required:
 *         - authorName
 *         - title
 *         - description
 *         - content
 *         - createdBy
 *         - createdByModel
 *       properties:
 *         _id:
 *           type: string
 *           description: Auto-generated MongoDB ObjectId
 *         authorName:
 *           type: string
 *           description: Name of the blog author
 *         title:
 *           type: string
 *           description: Blog title
 *         description:
 *           type: string
 *           description: Brief description of the blog
 *         content:
 *           type: string
 *           description: Full blog content
 *         tags:
 *           type: array
 *           items:
 *             type: string
 *           description: Array of tags associated with the blog
 *         createdBy:
 *           type: string
 *           description: ID of the creator (user or doctor)
 *         createdByModel:
 *           type: string
 *           enum: [User, Doctor]
 *           description: Type of the creator
 *         createdAt:
 *           type: string
 *           format: date-time
 *           description: Blog creation timestamp
 *         updatedAt:
 *           type: string
 *           format: date-time
 *           description: Blog last update timestamp
 *         imageUrl:
 *           type: string
 *           description: URL to the blog image
 *       example:
 *         _id: 60d0fe4f5311236168a109cd
 *         authorName: John Doe
 *         title: Health Tips for Summer
 *         description: Important health tips to stay healthy during summer
 *         content: Lorem ipsum dolor sit amet, consectetur adipiscing elit...
 *         tags: [health, summer, tips]
 *         createdBy: 60d0fe4f5311236168a109ca
 *         createdByModel: User
 *         createdAt: 2023-05-10T08:15:00.000Z
 *         updatedAt: 2023-05-10T08:15:00.000Z
 *         imageUrl: /uploads/blog-images/summer-health.jpg
 */
const blogSchema = new mongoose.Schema({
  authorName: {
    type: String,
    required: [true, 'Author name is required']
  },
  title: {
    type: String,
    required: [true, 'Blog title is required'],
    trim: true
  },
  description: {
    type: String,
    required: [true, 'Blog description is required'],
    trim: true
  },
  content: {
    type: String,
    required: [true, 'Blog content is required']
  },
  tags: [{
    type: String,
    trim: true
  }],
  createdBy: {
    type: mongoose.Schema.Types.ObjectId,
    refPath: 'createdByModel',
    required: [true, 'Creator reference is required']
  },
  createdByModel: {
    type: String,
    required: true,
    enum: ['User', 'Doctor']
  },
  createdAt: {
    type: Date,
    default: Date.now
  },
  updatedAt: {
    type: Date,
    default: Date.now
  },
  imageUrl: {
    type: String,
    default: null
  }
});

// Update the 'updatedAt' field on save
blogSchema.pre('save', function(next) {
  this.updatedAt = Date.now();
  next();
});

const Blog = mongoose.model('Blog', blogSchema);

module.exports = Blog; 