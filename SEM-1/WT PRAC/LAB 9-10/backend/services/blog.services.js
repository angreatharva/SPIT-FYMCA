const BlogModel = require("../model/blog.model");

class BlogService {
  static async createBlog(data) {
    try {
      const createBlog = new BlogModel(data);
      return await createBlog.save();
    } catch (e) {
      throw e;
    }
  }

  static async getAllBlogs() {
    try {
      return await BlogModel.find();
    } catch (e) {
      throw e;
    }
  }

  static async updateBlog(id, data) {
    try {
      return await BlogModel.findByIdAndUpdate(id, data, { new: true });
    } catch (e) {
      throw e;
    }
  }

  static async getBlogById(id) {
    try {
      return await BlogModel.findById(id);
    } catch (e) {
      throw e;
    }
  }

  static async deleteBlogById(id) {
    try {
      return await BlogModel.findByIdAndDelete(id);
    } catch (e) {
      throw e;
    }
  }

  static async getBlogsByAuthor(by) {
    try {
      return await BlogModel.find({ by });
    } catch (e) {
      throw e;
    }
  }
}

module.exports = BlogService;
