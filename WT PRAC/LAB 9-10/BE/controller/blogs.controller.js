const { response } = require("../app");
const BlogService = require("../services/blog.services");

// Create a blog with binary image data
exports.createBlog = async (req, res) => {
  try {
    const { title, smallDesc, longDesc, by, imageBase64 } = req.body;

    // Validate presence of fields except imageBase64
    if (!title || !smallDesc || !longDesc || !by) {
      return res.status(400).json({
        registered: false,
        response: "Title, description fields, and author are required",
      });
    }

    // Decode image only if provided
    let imageBuffer = null;
    if (imageBase64) {
      imageBuffer = Buffer.from(imageBase64, "base64");
    }

    const blogData = {
      title,
      smallDesc,
      longDesc,
      by,
      image: imageBuffer,
    };

    const result = await BlogService.createBlog(blogData);

    if (!result) {
      throw new Error("Failed to save blog");
    }

    res.status(201).json({
      registered: true,
      response: "Blog Created Successfully!",
    });
  } catch (e) {
    console.error("Error in creating blog:", e.message);
    res.status(500).json({
      registered: false,
      response: "Error creating blog",
    });
  }
};
// Send the blog image back in response as binary
exports.getBlogImage = async (req, res) => {
  try {
    const { id } = req.params;
    const imageBuffer = await BlogService.getBlogImageById(id);

    if (!imageBuffer) {
      return res.status(404).json({
        status: false,
        response: "Image not found",
      });
    }

    // Set response headers to indicate image type
    res.set("Content-Type", "image/jpeg");
    res.send(imageBuffer);
  } catch (e) {
    console.error("Error fetching image:", e.message);
    res.status(500).json({
      status: false,
      response: "Error fetching image",
    });
  }
};
exports.getAllBlogs = async (req, res, next) => {
  try {
    const students = await BlogService.getAllBlogs();
    res.json({ data: students });
  } catch (e) {
    res.status(500).json({ status: false, message: e.message });
  }
};

exports.updateBlog = async (req, res) => {
  try {
    const { id } = req.params;
    const updatedData = req.body;

    const updatedBlog = await BlogService.updateBlog(id, updatedData);

    if (!updatedBlog) {
      return res.status(404).json({
        status: false,
        response: "Blog not found",
      });
    }

    res.status(200).json({
      status: true,
      response: "Blog updated successfully!",
    });
  } catch (e) {
    console.error("Error Updating Blog:", e);
    res.status(500).json({
      status: false,
      response: "Error updating blog",
    });
  }
};

exports.getBlogById = async (req, res) => {
  try {
    const { id } = req.params; // Get blog ID from URL

    const blog = await BlogService.getBlogById(id);

    if (!blog) {
      return res.status(404).json({
        status: false,
        response: "Blog not found",
      });
    }

    res.status(200).json({
      status: true,
      data: blog,
    });
  } catch (e) {
    console.error("Error Fetching Blog:", e);
    res.status(500).json({
      status: false,
      response: "Error fetching blog",
    });
  }
};

exports.getBlogsByAuthor = async (req, res) => {
  try {
    const { by } = req.params; // Extract the author's name/ID from URL
    const blogs = await BlogService.getBlogsByAuthor(by);

    if (!blogs || blogs.length === 0) {
      return res.status(404).json({
        status: false,
        response: "No blogs found for this author",
      });
    }

    res.status(200).json({
      status: true,
      data: blogs,
    });
  } catch (e) {
    console.error("Error fetching blogs by author:", e);
    res.status(500).json({
      status: false,
      response: "Error fetching blogs",
    });
  }
};

exports.deleteBlogById = async (req, res) => {
  try {
    const { id } = req.params;

    const deletedBlog = await BlogService.deleteBlogById(id);

    if (!deletedBlog) {
      return res.status(404).json({
        status: false,
        response: "Blog not found",
      });
    }

    res.status(200).json({
      status: true,
      response: "Blog deleted successfully!",
    });
  } catch (e) {
    console.error("Error Deleting Blog:", e);
    res.status(500).json({
      status: false,
      response: "Error deleting blog",
    });
  }
};
