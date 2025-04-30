const mongoose = require('mongoose');

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