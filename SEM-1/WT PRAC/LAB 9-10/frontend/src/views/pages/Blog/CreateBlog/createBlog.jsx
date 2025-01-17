import React, { useState } from "react";
import axios from "axios";
import "./createBlog.css";

const CreateBlogForm = () => {
  const [title, setTitle] = useState("");
  const [smallDesc, setSmallDesc] = useState("");
  const [longDesc, setLongDesc] = useState("");
  const [by, setBy] = useState("");
  const [imageBase64, setImageBase64] = useState("");

  const handleImageChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setImageBase64(reader.result.split(",")[1]);
      };
      reader.readAsDataURL(file);
    }
  };

  const handleSubmit = async () => {
    const requestData = {
      title,
      smallDesc,
      longDesc,
      by,
      imageBase64,
    };

    try {
      const response = await axios.post(
        "http://localhost:3001/createBlog",
        requestData,
        { headers: { "Content-Type": "application/json" } }
      );

      console.log("Response:", response.data);
      alert("Blog Submitted Successfully!");
    } catch (error) {
      console.error("Error submitting blog:", error);
      alert("Something went wrong...");
    }
  };

  return (
    <div className="create-blog-page">
      <div className="create-blog-container">
        <h1>Create New Blog</h1>
        <div className="blog-form">
          <div className="form-row">
            <input
              type="text"
              placeholder="Enter Blog Title"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              className="title-input"
            />
            <input
              type="text"
              placeholder="Write a Small Description"
              value={smallDesc}
              onChange={(e) => setSmallDesc(e.target.value)}
              className="small-desc-input"
            />
          </div>

          <div className="form-row">
            <textarea
              placeholder="Write Your Long Description"
              value={longDesc}
              onChange={(e) => setLongDesc(e.target.value)}
              className="long-desc-input"
            />
          </div>

          <div className="form-row">
            <input
              type="text"
              placeholder="Enter Author Name"
              value={by}
              onChange={(e) => setBy(e.target.value)}
              className="author-input"
            />
            <label className="file-upload-label">
              Upload a Blog Cover Image
              <input type="file" onChange={handleImageChange} />
            </label>
          </div>

          <div className="form-row">
            <button className="submit-btn" onClick={handleSubmit}>
              Submit Blog
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};

export default CreateBlogForm;
