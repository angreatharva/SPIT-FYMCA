import React, { useEffect, useState } from "react";
import axios from "axios";
import { Buffer } from "buffer";
import { useNavigate } from "react-router-dom";
import "./allBlog.css";

const BlogList = () => {
  const [blogs, setBlogs] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const navigate = useNavigate();

  useEffect(() => {
    const fetchBlogs = async () => {
      try {
        const response = await axios.get("http://localhost:3001/allBlog");

        console.log("Response Data:", response.data);

        if (response?.data?.data?.length) {
          const blogs = response.data.data.map((blog) => ({
            ...blog,
            image: blog.image?.data
              ? `data:image/jpeg;base64,${Buffer.from(blog.image.data).toString(
                  "base64"
                )}`
              : "",
          }));
          setBlogs(blogs);
        } else {
          setError("No blogs found.");
        }
      } catch (err) {
        console.error("Error fetching blogs:", err);
        setError("Failed to load blogs");
      } finally {
        setLoading(false);
      }
    };

    fetchBlogs();
  }, []);

  if (loading) return <p>Loading blogs...</p>;
  if (error) return <p>{error}</p>;

  return (
    <div className="blog-list">
      <h1>Blog List</h1>
      {blogs.map((blog) => (
        <div
          key={blog._id}
          className="blog-card"
          onClick={() => navigate(`/blog/${blog._id}`)}
          style={{ cursor: "pointer" }}
        >
          <h2>{blog.title}</h2>
          {blog.image && (
            <img src={blog.image} alt={blog.title} className="blog-image" />
          )}
          <p>{blog.smallDesc}</p>
          <p>
            <strong>By:</strong> {blog.by}
          </p>
        </div>
      ))}
    </div>
  );
};

export default BlogList;
