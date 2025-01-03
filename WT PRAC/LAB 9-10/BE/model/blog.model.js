const mongoose = require("../config/db");
const { Schema } = mongoose;

const blogSchema = new Schema({
  title: {
    type: String,
    required: true,
  },
  image: {
    type: Buffer,
  },
  smallDesc: {
    type: String,
    required: true,
  },
  longDesc: {
    type: String,
    required: true,
  },
  by: {
    type: String,
    required: true,
  },
});

const BlogModel = mongoose.model("blogs", blogSchema, "blogs");
module.exports = BlogModel;
