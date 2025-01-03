import React, { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import axios from "axios";
import { Buffer } from "buffer";
import "./blogDetails.css";

const BlogDetails = () => {
  const { id } = useParams();
  const [blog, setBlog] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchBlog = async () => {
      try {
        const response = await axios.get(`http://localhost:3001/getBlog/${id}`);
        const blog = response.data.data;

        setBlog({
          ...blog,
          image: `data:image/jpeg;base64,${Buffer.from(
            blog.image.data
          ).toString("base64")}`,
        });
      } catch (err) {
        console.error("Error fetching blog details:", err);
        setError("Failed to load blog details");
      } finally {
        setLoading(false);
      }
    };

    fetchBlog();
  }, [id]);

  if (loading) return <p>Loading blog details...</p>;
  if (error) return <p>{error}</p>;

  return (
    <div className="blog-details">
      <h1>{blog.title}</h1>
      <img src={blog.image} alt={blog.title} className="blog-details-image" />
      <p>{blog.longDesc}</p>
      <p>
        <strong>By:</strong> {blog.by}
      </p>
    </div>
  );
};

export default BlogDetails;
