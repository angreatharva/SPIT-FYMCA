import React from "react";
import { BrowserRouter as Router, Routes, Route } from "react-router-dom";
import Register from "./views/pages/Registration/registrationPage";
import Homepage from "./views/pages/HomePage/homePage";
import CreateBlog from "./views/pages/Blog/CreateBlog/createBlog";
import AllBlog from "./views/pages/Blog/AllBlog/allBlog";
import BlogDetails from "./views/pages/Blog/AllBlog/blogDetails";
import Doctors from "./views/pages/Doctor/doctorList";

function App() {
  return (
    <Router>
      <div className="App">
        <Routes>
          <Route path="/" element={<Homepage />} />
          <Route path="/doctors" element={<Doctors />} />
          <Route path="/blog/:id" element={<BlogDetails />} />
          <Route path="/registrationPage" element={<Register />} />
          <Route path="/CreateBlog" element={<CreateBlog />} />
          <Route path="/blog" element={<AllBlog />} />
        </Routes>
      </div>
    </Router>
  );
}

export default App;
